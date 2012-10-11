class Package < ActiveRecord::Base
  attr_accessible :description, :license, :name, :publication_date, :r_version, :title, :version, :original_package_id

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :maintainers
  has_and_belongs_to_many :dependencies, :class_name => "Package", :join_table => "packages_dependencies", 
                          :association_foreign_key => "dependency_id", :foreign_key => "package_id"

  has_many :versions, :class_name => "Package", :foreign_key => "original_package_id"
  belongs_to :original_package, :class_name => "Package"

  validates_presence_of :name, :version, :message => "can't be blank"
end
