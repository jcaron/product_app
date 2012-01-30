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
      it "creates a new SubCategory"
        
      it "assigns a newly created sub_category as @sub_category"
        
      it "redirects to the created sub_category"
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sub_category as @sub_category"
        
      it "re-renders the 'new' template"
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested sub_category"
        
      it "assigns the requested sub_category as @sub_category"
        
      it "redirects to the sub_category"
    end

    describe "with invalid params" do
      it "assigns the sub_category as @sub_category"
        
      it "re-renders the 'edit' template"
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested sub_category"
      
    it "redirects to the sub_categories list"
  end

end
