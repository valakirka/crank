require 'spec_helper'

describe Maintainer do
  it "should not be valid without a name and an email" do
    Maintainer.new(:name => nil, :email => "wadus@wadus.com").should_not be_valid
    Maintainer.new(:name => "David Heinemeier", :email => nil).should_not be_valid
  end

  it "should have and belong to many packages" do
      m = Maintainer.reflect_on_association(:packages)
      m.macro.should == :has_and_belongs_to_many
  end
end
