require 'spec_helper'

describe SubCategory do
  before(:each) do
    @category = Factory(:category)
    @attr = { :name => "Power Tube" }
  end

  describe "category associations" do
    before(:each) do
      @sub_category = @category.sub_categories.create!(@attr)
    end

    it "should have a category attribute" do
      @sub_category.should respond_to(:category)
    end

    it "should have the right associated category" do
      @sub_category.category_id.should == @category.id
      @sub_category.category.should == @category
    end
  end

  describe "validations" do
    it "should allow the same name under different categories"

    it "should not allow the same name under the same category"
  end
end

# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

