require 'spec_helper'

describe Category do
  before(:each) do
    @category = Factory(:category)
    @sub_category = @category.sub_categories.create!(:name => "Power Tube")
  end

  describe "sub-categories association" do
    it "should have a sub_categories attribute" do
      @category.should respond_to(:sub_categories)
    end

    it "should have the right sub-category in sub_categories" do
      @category.sub_categories.should == [@sub_category]
    end

    it "should destroy the sub_categories if their category is destroyed" do
      @category.destroy
      SubCategory.find_by_id(@sub_category.id).should be_nil
    end
  end

  describe "product associations" do
    before(:each) do
      @product = Product.create!(:name => "x", :category_id => @category.id, 
        :sub_category_id => @sub_category.id)
        Factory(:product, :sub_category_id => @sub_category.id + 1, 
          :category_id => @category.id + 1)
      @product.relationships.create!(:sub_category_id => @sub_category.id)
    end

    it "should have a products attribute" do
      @category.should respond_to(:products)
    end
    
    it "should have the right products and no others" do
      @category.products.should == [@product]
    end
  end

  describe "validations" do
    it "should require a non-blank name" do
      Category.new(:name => "").should_not be_valid
    end

    it "should reject long names" do
      long_name = 'a' * 51
      Category.new(:name => long_name).should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

