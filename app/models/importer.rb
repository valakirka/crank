require 'dcf'
require 'open-uri'

class Importer
  PACKAGES_DIR = "http://mirrors.softliste.de/cran/src/contrib/"

  def self.get_packages_list
    Dcf.parse open(PACKAGES_DIR + "PACKAGES").read
  end

  def self.create_packages(list)
    list.each do |new_package|
      packages = Package.where(:name => new_package['Package'])
      same_version = packages.detect{|p| p.version == new_package['Version']}

      if packages.empty? || same_version.nil?
        self.download_package_file("#{new_package['Package']}_#{new_package['Version']}.tar.gz")
        data = self.extract_info_from_file("#{new_package['Package']}_#{new_package['Version']}.tar.gz")

        if !packages.empty?
          self.create_new_package(data, package.id)
        else
          self.create_new_package(data)
        end
      end
    end
  end

  def self.download_package_file(file_name)
    File.open(File.join("tmp", file_name), "wb") do |file|
      file.write open(PACKAGES_DIR + file_name).read
    end
  end

  def self.extract_info_from_file(file_name)
    data = nil
    # Rubygems has a very nice utility to read TAR files
    Gem::Package::TarReader.new(Zlib::GzipReader.open(Rails.root.join("tmp", file_name))).each do |entry|
      data = Dcf.parse entry.read if entry.full_name =~ /.?DESCRIPTION/
    end
    data.first
  end

  def self.create_new_package(package_data, original_package_id = nil)
      Package.create(:name => package_data["Package"], :version => package_data["Version"], :title => package_data['Title'], 
                     :description => package_data['Description'], :publication_date => DateTime.strptime(package_data["Date/Publication"], "%Y-%m-%d %H:%M:%S"),
                     :license => package_data['License'], :original_package_id => original_package_id)
  end
end