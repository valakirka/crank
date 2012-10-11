class Author < ActiveRecord::Base
  attr_accessible :email, :name

  has_and_belongs_to_many :packages

  validates_presence_of :name, :email, :message => "can't be blank"
end
