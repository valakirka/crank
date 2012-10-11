require 'spec_helper'

describe Package do
  it "should not be valid without a name and a version" do
    Package.new(:name => nil, :version => "1.0").should_not be_valid
    Package.new(:name => "abc", :version => nil).should_not be_valid
  end

  it "should have and belong to many authors" do
      p = Package.reflect_on_association(:authors)
      p.macro.should == :has_and_belongs_to_many
  end

  it "should have and belong to many maintainers" do
      p = Package.reflect_on_association(:maintainers)
      p.macro.should == :has_and_belongs_to_many
  end

  it "should have many versions" do
      p = Package.reflect_on_association(:versions)
      p.macro.should == :has_many
  end
end
