class Package < ActiveRecord::Base
  attr_accessible :description, :license, :name, :publication_date, :r_version, :title, :version

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :maintainers
  has_many :versions, :class_name => "Package", :foreign_key => "original_package_id"
  belongs_to :original_package, :class_name => "Package"

  validates_presence_of :name, :version, :message => "can't be blank"
end
