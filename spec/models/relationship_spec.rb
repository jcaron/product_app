require 'spec_helper'

describe Relationship do
    before(:each) do
        category = Factory(:category)
        @sub_category = Factory(:sub_category, :category_id => category.id)
        @product = Factory(:product, :category_id => category.id, 
          :sub_category_id => @sub_category.id)
        @relationship = @product.relationships.build(
            :sub_category_id => @sub_category.id)
    end
    
    it "should create a new relationship given valid attributes" do
        @relationship.save!
    end
    
    describe 'validations' do
        it "should require a sub-category id" do
            @relationship.sub_category_id = nil
            @relationship.should_not be_valid
        end
        
        it "should require a product id" do
            @relationship.product_id = nil
            @relationship.should_not be_valid
        end
    end
    
    describe 'dependancy' do
        before(:each) do
            @relationship.save
        end
        
        it "should destroy a relationship if the sub-category is destroyed" do
            @sub_category.destroy
            Relationship.find_by_id(@relationship.id).should be_nil
        end
        
        it "should destroy a relationship if the product is destroyed" do
            @product.destroy
            Relationship.find_by_id(@relationship.id).should be_nil
        end
    end
end

# == Schema Information
#
# Table name: relationships
#
#  id              :integer         not null, primary key
#  sub_category_id :integer
#  product_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

