require 'spec_helper'

describe SubCategoriesController do

  render_views

  describe "GET index" do
    it "should be successful" do
      get :index
      response.should be_success
    end

    describe "content checks" do
      before(:each) do
        @category = Factory(:category)
        sub_cat1 = @category.sub_categories.create!(:name => "Power Tube")
        sub_cat2 = @category.sub_categories.create!(:name => "Preamp Tube")
        category = Factory(:category, :name => "Vac Tube")
        sub_cat3 = category.sub_categories.create!(:name => "Rectifier Tube")
        @sub_cats = [sub_cat1, sub_cat2, sub_cat3]
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Sub-categories")
      end

      it "assigns all sub_categories as @sub_categories" do
        get :index
        @sub_cats.each do |sub_category|
          response.should have_selector("td", :content => sub_category.name)
        end
      end

      it "should include the category name" do
        get :index
        response.should have_selector("td>a", :content => @category.name, 
          :href => category_path(@category))
      end
    end
  end

  describe "GET show" do
    before(:each) do
      @category = Factory(:category)
      @sub_category = Factory(:sub_category, :category_id => @category.id)
      get :show, :id => @sub_category.to_param
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => @sub_category.name)
    end

    it "shows a link to the category" do
      response.should have_selector("a", :content => @category.name, 
        :href => category_path(@category))
    end
  end

  describe "GET new" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "New")
    end
  end

  describe "GET edit" do
    before(:each) do
      @category = Factory(:category)
      @sub_category = Factory(:sub_category, :category_id => @category.id)
      get :edit, :id => @sub_category.to_param
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Edit")
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        category = Factory(:category)
        @attr = { :name => 'Power Tube', :category_id => category.id }
      end

      it "creates a new SubCategory" do
        lambda do
          post :create, :sub_category => @attr
        end.should change(SubCategory, :count)
      end
        
      it "assigns a newly created sub_category as @sub_category" do
        post :create, :sub_category => @attr
        assigns(:sub_category).should be_a(SubCategory)
        assigns(:sub_category).should be_persisted
      end
        
      it "redirects to the created sub_category" do
        post :create, :sub_category => @attr
        response.should redirect_to(SubCategory.last)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @category = Factory(:category)
        @attr = { :name => "" }
      end

      it "does not create a new sub-category" do
        lambda do
          post :create, :sub_category => @attr
        end.should_not change(SubCategory, :count)
      end
 
      it "re-renders to the 'new' template if no category" do
        post :create, :sub_category => @attr
        response.should render_template('new')
      end

      it "re-renders the 'new' template if no name" do
        post :create, :sub_category => { :category_id => @category.id }
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before(:each) do
        @category = Factory(:category)
        @sub_category = Factory(:sub_category, :category_id => @category.id)
        @attr = { :name => 'new name', :category_id => @category.id }
        post :update, :id => @sub_category.to_param, :sub_category => @attr
      end

      it "updates the requested sub_category" do
        SubCategory.find(@sub_category.id).name.should eq(@attr[:name])
      end
        
      it "assigns the requested sub_category as @sub_category" do
        assigns(:sub_category).should eq(@sub_category)
      end
        
      it "redirects to the sub_category" do
        response.should redirect_to @sub_category
      end
    end

    describe "with invalid params" do
      before(:each) do
        c = Factory(:category)
        @sub_category = Factory(:sub_category, :category_id => c.id)
        @attr = { :name => "" }
        post :update, :id => @sub_category.to_param, :sub_category => @attr
      end

      it "assigns the sub_category as @sub_category" do
        assigns(:sub_category).should eq(@sub_category)
      end
        
      it "re-renders the 'edit' template" do
        response.should render_template 'edit'
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      c = Factory(:category)
      @sub_category = Factory(:sub_category, :category_id => c.id)
      Factory(:sub_category, :name => Factory.next(:name), :category_id => c.id)
    end

    it "destroys the requested sub_category" do
      expect {
        delete :destroy, :id => @sub_category.to_param
      }.to change(SubCategory, :count).by(-1)
    end
      
    it "redirects to the sub_categories list" do
      delete :destroy, :id => @sub_category.to_param
      response.should redirect_to sub_categories_path
    end
  end
end
