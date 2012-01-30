require 'spec_helper'

describe PagesController do

  render_views

  describe "GET 'home'" do
    before(:each) do
      get :home
    end

    it "returns http success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Home")
    end
  end

  describe "GET 'about'" do
    before(:each) do
      get :about
    end

    it "returns http success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "About")
    end
  end

  describe "GET 'help'" do
    before(:each) do
      get :help
    end

    it "returns http success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Help")
    end
  end

  describe "GET 'new'" do
    before(:each) do
      get :new
    end

    it "returns http success" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Forms root")
    end
  end
end
