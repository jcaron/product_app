require "spec_helper"

describe SubCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/sub_categories").should route_to("sub_categories#index")
    end

    it "routes to #new" do
      get("/sub_categories/new").should route_to("sub_categories#new")
    end

    it "routes to #show" do
      get("/sub_categories/1").should route_to("sub_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sub_categories/1/edit").should route_to("sub_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sub_categories").should route_to("sub_categories#create")
    end

    it "routes to #update" do
      put("/sub_categories/1").should route_to("sub_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sub_categories/1").should route_to("sub_categories#destroy", :id => "1")
    end

  end
end
