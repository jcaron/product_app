require 'spec_helper'

describe CategoriesController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Category. As you add validations to Category, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => "Electronics" }
  end
  
  describe "for anonymous users" do
    describe "GET index" do
      it "assigns all categories as @categories" do
        category = Category.create! valid_attributes
        get :index, {}
        assigns(:categories).should eq([category])
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Category Index")
      end
    end

    describe "GET show" do
      before(:each) do
        @category = Category.create! valid_attributes
        @sub1 = @category.sub_categories.create!(:name => "Example 1")
        @sub2 = @category.sub_categories.create!(:name => "Example 2")
        get :show, :id => @category.to_param
      end

      it "assigns the requested category as @category" do
        assigns(:category).should eq(@category)
      end

      it "should have the right title" do
        response.should have_selector("title", :content => @category.name)
      end

      it "should display links to its sub-categories" do
        response.should have_selector("li>a", :content => @sub1.name )
        response.should have_selector("li>a", :content => @sub2.name )
      end
    end
  end


  describe "for signed in users" do
    before(:each) do
      user = Factory(:user)
      sign_in user
    end

    describe "GET new" do
      it "assigns a new category as @category" do
        get :new, {}
        assigns(:category).should be_a_new(Category)
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New category")
      end
    end

    describe "GET edit" do
      before(:each) do
        @category = Category.create! valid_attributes
        get :edit, :id => @category.to_param
      end

      it "assigns the requested category as @category" do
        assigns(:category).should eq(@category)
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "#{@category.name}")
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Category" do
          expect {
            post :create, :category => valid_attributes
          }.to change(Category, :count).by(1)
        end

        it "assigns a newly created category as @category" do
          post :create, :category => valid_attributes
          assigns(:category).should be_a(Category)
          assigns(:category).should be_persisted
        end

        it "redirects to the created category" do
          post :create, :category => valid_attributes
          response.should redirect_to(Category.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved category as @category" do
          # Trigger the behavior that occurs when invalid params are submitted
          Category.any_instance.stub(:save).and_return(false)
          post :create, :category => {}
          assigns(:category).should be_a_new(Category)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Category.any_instance.stub(:save).and_return(false)
          post :create, :category => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested category" do
          category = Category.create! valid_attributes
          # Assuming there are no other categories in the database, this
          # specifies that the Category created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Category.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => category.to_param, :category => {'these' => 'params'}
        end

        it "assigns the requested category as @category" do
          category = Category.create! valid_attributes
          put :update, :id => category.to_param, :category => valid_attributes
          assigns(:category).should eq(category)
        end

        it "redirects to the category" do
          category = Category.create! valid_attributes
          put :update, :id => category.to_param, :category => valid_attributes
          response.should redirect_to(category)
        end
      end

      describe "with invalid params" do
        it "assigns the category as @category" do
          category = Category.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Category.any_instance.stub(:save).and_return(false)
          put :update, :id => category.to_param, :category => {}
          assigns(:category).should eq(category)
        end

        it "re-renders the 'edit' template" do
          category = Category.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Category.any_instance.stub(:save).and_return(false)
          put :update, :id => category.to_param, :category => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        @category = Category.create! valid_attributes
        @sub_category = @category.sub_categories.create!(:name => "ex")
        category = Factory(:category)
        category.sub_categories.create!(:name => "ex2")
      end

      it "destroys the requested category" do
        expect {
          delete :destroy, :id => @category.to_param
        }.to change(Category, :count).by(-1)
      end

      it "redirects to the categories list" do
        delete :destroy, :id => @category.to_param
        response.should redirect_to(categories_url)
      end

      it "destroys all sub-categories that belong to it and no others" do
        expect {
          delete :destroy, :id => @category.to_param
        }.to change(SubCategory, :count).by(-1)
      end
    end
  end
end
