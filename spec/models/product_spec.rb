require 'spec_helper'

describe Product do
    before(:each) do
        @category = Factory(:category)
        @sub_category = Factory(:sub_category, :category_id => @category.id)
        @attr = { :name => "xyzzy", :category_id => @category.id, 
          :sub_category_id => [@sub_category.id] }
    end

    describe "sub-category associations" do
        before(:each) do
            @product = Product.create!(@attr)
            @relationship = @product.relationships.create!(
              :sub_category_id => @sub_category.id)
            @sub_category_2 = Factory(:sub_category, :name => "null",
                :category_id => @category.id)
        end
        
        it "should have a sub_categories attribute" do
            @product.should respond_to(:sub_categories)
        end
        
        it "should respond to add_sub_category!" do
            @product.should respond_to(:add_sub_category!)
        end

        it "should respond to has_sub_category?" do
            @product.should respond_to(:has_sub_category?)
        end
        
        it "should have the right sub-categories and no others" do
            @product.sub_categories.should == [@sub_category]
        end
        
        it "should not create a relationship to a different category" do
            category = Factory(:category, :name => Factory.next(:name))
            sub_cat = Factory(:sub_category, :category_id => category.id)
            lambda do
                @product.add_sub_category!(sub_cat.id)
            end.should_not change(Relationship, :count)
        end

        describe 'dependance' do
            before(:each) do
                @relationship2 = @product.add_sub_category! @sub_category_2
                @relationship.destroy
            end
            
            it "should not be destroyed if one relationship is destroyed" do
                Product.find_by_id(@product.id).should_not be_nil
            end
                
            it "should destroy the product if it has no sub-categories" do
                @relationship2.destroy
                Product.find_by_id(@product.id).should be_nil
            end
        end
    end
    
    describe "validations" do
        it "should create a product with valid attributes" do
            product = Product.new(@attr)
            product.save.should be_true
        end
        
        it "should require a name" do
            product = Product.new(@attr.merge(:name => ''))
            product.should_not be_valid
        end
        
        it "should reject a long name" do
            name = 'a'*51
            product = Product.new(@attr.merge(:name => name))
            product.should_not be_valid
        end
    end
end

# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

