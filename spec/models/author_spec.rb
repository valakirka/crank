require 'spec_helper'

describe Author do
  it "should not be valid without a name and an email" do
    Author.new(:name => nil, :email => "wadus@wadus.com").should_not be_valid
    Author.new(:name => "David Heinemeier", :email => nil).should_not be_valid
  end

  it "should have and belong to many packages" do
      a = Author.reflect_on_association(:packages)
      a.macro.should == :has_and_belongs_to_many
  end
end
