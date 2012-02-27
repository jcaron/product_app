require 'spec_helper'

describe CartsController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Cart. As you add validations to Cart, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CartsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "for signed-in users" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it 'should assign a cart to a user who has none' do
      get 'show'
      @user.cart.should_not be_nil
    end

    it 'should ignore the cart in the cookies in favor of the users cart' do
      cart = Cart.create
      session[:cart_id] = cart.id
      get 'show'
      assigns(:current_cart).should_not eq cart
      session[:cart_id].should eq cart.id
    end
  end

  describe "GET show" do
    it "assigns the requested cart as @cart" do
      cart = Cart.create! valid_attributes
      session[:cart_id] = cart.id
      get :show, {:id => cart.to_param}, session
      assigns(:cart).should eq(cart)
    end
  end

  describe "GET edit" do
    it "assigns the requested cart as @cart" do
      cart = Cart.create! valid_attributes
      session[:cart_id] = cart.id
      get :edit, {:id => cart.to_param}, session
      assigns(:cart).should eq(cart)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cart" do
        expect {
          post :create, {:cart => valid_attributes}, valid_session
        }.to change(Cart, :count).by(1)
      end

      it "assigns a newly created cart as @cart" do
        post :create, {:cart => valid_attributes}, valid_session
        assigns(:cart).should be_a(Cart)
        assigns(:cart).should be_persisted
      end

      it "redirects to the created cart" do
        post :create, {:cart => valid_attributes}, valid_session
        response.should redirect_to(Cart.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cart as @cart" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cart.any_instance.stub(:save).and_return(false)
        post :create, {:cart => {}}, valid_session
        assigns(:cart).should be_a_new(Cart)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cart.any_instance.stub(:save).and_return(false)
        post :create, {:cart => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

describe "DELETE destroy" do
    it "destroys the requested cart" do
      cart = Cart.create! valid_attributes
      expect {
        delete :destroy, {:id => cart.to_param}, valid_session
      }.to change(Cart, :count).by(-1)
    end

    it "redirects to the carts list" do
      cart = Cart.create! valid_attributes
      delete :destroy, {:id => cart.to_param}, valid_session
      response.should redirect_to(carts_url)
    end
  end

end
