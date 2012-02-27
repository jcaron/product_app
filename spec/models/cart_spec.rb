require 'spec_helper'

describe Cart do
    before(:each) do
        @category = Factory(:category)
        @sub_cate = Factory(:sub_category, :category_id => @category.id)
        @product = Factory(:product, :sub_category_id => [@sub_cate.id], 
                           :category_id => @category.id, :unit_price => 1)
        @cart = Cart.create!
    end
    
    describe "associations" do
        it 'should have line_items' do
            @cart.should respond_to(:line_items)
        end
        
        it 'should have the right line items' do
            cart = Cart.create!
            line_item1 = @cart.line_items.create!(:product_id => @product.id)
            line_item2 = cart.line_items.create!(:product_id => @product.id)
            @cart.line_items.should eq([line_item1])
        end
        
        it 'should have the right products' do
            line_item = @cart.line_items.create!(:product_id => @product.id)
            @cart.line_items[0].product.should eq @product
        end

        it 'should have a user' do
          @cart.should respond_to :user
        end

        it 'should get the right user' do
          user = Factory(:user)
          @cart.user_id = user.id
          @cart.user.should eq user
        end
    end
    
    describe "method tests" do
        before(:each) do
            @line_item = @cart.line_items.create(:product_id => @product.id, 
                                                 :quantity => 1)
        end
        
        it 'should respond to total_price' do
            @cart.should respond_to(:total_price)
        end
        
        it 'should give the correct price' do
            @cart.total_price.should eq(@product.unit_price)
            @line_item.destroy
            @cart.reload
            @cart.total_price.should eq(0)
        end
        
        it 'should respond to total_items_in_cart' do
            @cart.should respond_to(:total_items_in_cart)
        end
        
        it 'should give the correct number of items' do
            @cart.total_items_in_cart.should eq 1
            @line_item.destroy
            @cart.reload
            @cart.total_items_in_cart.should eq 0
        end
        
        it 'should destroy line items with 0 quantity after saving' do
            @line_item.quantity = 0
            @line_item.save
            @cart.save
            @cart.reload
            @cart.line_items.should be_empty
        end
    end
end


# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  order_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

