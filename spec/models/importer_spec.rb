require 'spec_helper'

describe Importer do
  before(:each) do
    stub_request(:get, "http://mirrors.softliste.de/cran/src/contrib/PACKAGES").to_return(:status => 200, :body => "Package: abc\nVersion: 1.6\nDepends: R (>= 2.10), MASS, nnet, quantreg, locfit\nLicense: GPL (>= 3)")
    stub_request(:get, "http://mirrors.softliste.de/cran/src/contrib/abc_1.6.tar.gz").to_return(:status => 200, :body => File.new(Rails.root.join("spec", "fixtures", "abc_1.6.tar.gz")), :headers => {})
  end

  it "should get the list of available packages" do
    Importer.get_packages_list.first.should == {"Package"=>"abc", "Version"=>"1.6", "Depends"=>"R (>= 2.10), MASS, nnet, quantreg, locfit", "License"=>"GPL (>= 3)"}
  end

  it "should download files when needed" do
    Importer.download_package_file("abc_1.6.tar.gz")
    File.exist?("tmp/abc_1.6.tar.gz").should be_true
  end

  it "should extract info from the package file to create a new one" do
    data = Importer.extract_info_from_file(Rails.root.join("spec", "fixtures", "abc_1.6.tar.gz"))
    data.should == {"Package"=>"abc", "Version"=>"1.6", "Date"=>"2012-16-02", "Title"=>"Tools for Approximate Bayesian Computation (ABC)", 
                    "Author"=>"Katalin Csillery, Michael Blum and Olivier Francois", "Maintainer"=>"Michael Blum <michael.blum@imag.fr>",
                    "Depends"=>"R (>= 2.10), MASS, nnet, quantreg, locfit", 
                    "Description"=>"The package implements several ABC algorithms for performing parameter estimation and model selection. Cross-validation tools are also available for measuring the accuracy of ABC estimates, and to calculate the misclassification probabilities of different models.", 
                    "Repository"=>"CRAN", "License"=>"GPL (>= 3)", "Packaged"=>"2012-08-14 15:10:43 UTC; mblum", 
                    "Date/Publication"=>"2012-08-14 16:27:09"}
  end

  it "should be able to create a package from a data structure" do
    data = Importer.extract_info_from_file(Rails.root.join("spec", "fixtures", "abc_1.6.tar.gz"))
    Importer.create_new_package(data)
    Package.last.name.should == "abc"
    Package.last.version.should == "1.6"
  end

  it "should create a package if it doesn't exist" do
    list = Importer.get_packages_list
    Importer.create_packages(list)
    Package.first.name.should == "abc"
    Package.first.version.should == "1.6"
  end
end