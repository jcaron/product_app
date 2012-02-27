require 'spec_helper'

describe LineItem do
    before(:each) do
        category = Factory(:category)
        sub_cate = Factory(:sub_category, :category_id => category.id)
        @product = Factory(:product, :category_id => category.id, 
                           :sub_category_id => sub_cate.id, :unit_price => 1)
        @cart = Cart.create!
        @attr = {:product_id => @product.id}
    end
    
    describe "Cart and Product associations" do
        before(:each) do
            @line_item = @cart.line_items.create! @attr
        end
        
        it 'should have a product' do
            @line_item.should respond_to(:product)
        end
        
        it 'should have a cart' do
            @line_item.should respond_to(:cart)
        end
        
        it 'should respond to unit_price' do
            @line_item.should respond_to(:unit_price)
        end
        
        it 'should have the right unit price' do
            @line_item.unit_price.should eq(@product.unit_price)
        end
        
        it 'should respond to full_price' do
            @line_item.should respond_to(:full_price)
        end
        
        it 'should give the right price' do
            @line_item.full_price.should eq(@product.unit_price)
        end
        
        describe "dependency" do
            it 'should be destroyed if its product is destroyed' do
                @product.destroy
                LineItem.find_by_id(@line_item.id).should be_nil
            end
            
            it 'should be destroyed if its cart is destroyed' do
                @cart.destroy
                LineItem.find_by_id(@line_item.id).should be_nil
            end
        end
    end
    
    describe "validations" do
        it 'should require a product' do
            line_item = LineItem.new(@attr.merge(:product_id => ''))
            line_item.should_not be_valid
        end
        
        it 'should require a cart' do
            line_item = LineItem.new(@attr.merge(:cart_id => ''))
            line_item.should_not be_valid
        end
        
        it 'should require a numerical quantity' do
            line_item = LineItem.new(@attr.merge(:quantity => "zebra"))
            line_item.should_not be_valid
        end
        
        it 'should require a non-negative quantity' do
            line_item = LineItem.new(@attr.merge(:quantity => -1))
            line_item.should_not be_valid
        end
        
        it 'should require a unique product id within the same cart' do
            @cart.line_items.create! @attr
            line_item = LineItem.new(@attr)
            line_item.should_not be_valid
        end
        
        it 'should allow a line item with the same product in another cart' do
            @cart.line_items.create! @attr
            cart = Cart.create!
            line_item = cart.line_items.new @attr
            line_item.should be_valid
        end
    end
end


# == Schema Information
#
# Table name: line_items
#
#  id         :integer         not null, primary key
#  cart_id    :integer
#  product_id :integer
#  unit_price :decimal(, )     default(0.0)
#  quantity   :integer         default(1)
#  created_at :datetime
#  updated_at :datetime
#

