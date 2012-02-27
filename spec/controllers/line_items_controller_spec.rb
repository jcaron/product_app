require 'spec_helper'

describe LineItemsController do

  # This should return the minimal set of attributes required to create a valid
  # LineItem. As you add validations to LineItem, be sure to
  # update the return value of this method accordingly.
  def valid_attributes(product_id, cart_id)
    {:product_id => product_id, :cart_id => cart_id}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LineItemsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "POST create" do
    before(:each) do
      cat = Factory(:category)
      sub_cat = Factory(:sub_category, :category_id => cat.id)
      @pro = Factory(:product, :sub_category_id => sub_cat.id, :category_id => cat.id)
      @cart = Cart.create!
    end
    
    describe "with valid params" do
      it "creates a new LineItem" do
        expect {
          post :create, {:line_item => valid_attributes(@pro.id, @cart.id)}, valid_session
        }.to change(LineItem, :count).by(1)
      end

      it "assigns a newly created line_item as @line_item" do
        post :create, {:line_item => valid_attributes(@pro.id, @cart.id)}, valid_session
        assigns(:line_item).should be_a(LineItem)
        assigns(:line_item).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved line_item as @line_item" do
        # Trigger the behavior that occurs when invalid params are submitted
        LineItem.any_instance.stub(:save).and_return(false)
          post :create, {:line_item => {}}, valid_session
        assigns(:line_item).should be_a_new(LineItem)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      cat = Factory(:category)
      sub_cat = Factory(:sub_category, :category_id => cat.id)
      @pro = Factory(:product, :sub_category_id => sub_cat.id, 
                     :category_id => cat.id)
      @cart = Cart.create!
    end

    describe "with valid params" do
      it "updates the requested line_item" do
        line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
        # Assuming there are no other line_items in the database, this
        # specifies that the LineItem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        LineItem.any_instance.should_receive(:update_attributes).with({
          'quantity' => 2})
        put :update, {:id => line_item.to_param, :line_item => {:quantity => 2}}
      end

      it "assigns the requested line_item as @line_item" do
        line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
        put :update, {:id => line_item.to_param, :line_item => {:quantity => 2}}
        assigns(:line_item).should eq(line_item)
      end

      it "redirects to the product" do
        line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
        put :update, {:id => line_item.to_param, :line_item => {:quantity => 2}}
        response.should redirect_to(@pro)
      end
    end

    describe "with invalid params" do
      it "assigns the line_item as @line_item" do
        line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
        # Trigger the behavior that occurs when invalid params are submitted
        LineItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => line_item.to_param, :line_item => {:quantity =>-1}}
        assigns(:line_item).should eq(line_item)
      end

      it "redirects to root" do
        line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
        # Trigger the behavior that occurs when invalid params are submitted
        LineItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => line_item.to_param, :line_item => {:quantity =>-1}}
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      cat = Factory(:category)
      sub_cat = Factory(:sub_category, :category_id => cat.id)
      @pro = Factory(:product, :sub_category_id => sub_cat.id, 
                     :category_id => cat.id)
      @cart = Cart.create!
    end

    it "destroys the requested line_item" do
      line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
      expect {
        delete :destroy, {:id => line_item.to_param}, valid_session
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to the cart page" do
      line_item = LineItem.create! valid_attributes(@pro.id, @cart.id)
      delete :destroy, {:id => line_item.to_param}, valid_session
      response.should redirect_to(cart_path)
    end
  end

end
