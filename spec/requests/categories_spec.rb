require 'spec_helper'

describe "Categories" do

  before(:each) do
    integration_test_sign_in
  end

  it "should have a category index" do
    get categories_path
    response.status.should be(200)
  end

  describe "New" do
    describe "failure" do
      it 'should not make a new category' do
        lambda do
          visit new_category_path
          fill_in "Name", :with => ''
          click_button
          response.should render_template('categories/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Category, :count)
      end
    end

    describe "success" do
      it 'should make a new category' do
        lambda do
          visit new_category_path
          fill_in "Name", :with => "Category"
          click_button
          response.should render_template('categories/show')
          response.should have_selector("#notice", :content => 'success')
        end.should change(Category, :count).by(1)
      end
    end
  end
end
