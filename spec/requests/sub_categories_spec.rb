require 'spec_helper'

describe "SubCategories" do
  before(:each) do
    integration_test_sign_in
  end

  describe "New" do
    describe "failure" do
      it 'should not make a new sub-category' do
        lambda do
          visit new_sub_category_path
          fill_in "Name", :with => ''
          click_button
          response.should render_template('sub_categories/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(SubCategory, :count)
      end
    end

    describe "success" do
#      before(:each) do
 #       @category = Factory(:category)
  #    end

#      it "should create a new sub-category" do
 #       lambda do
  #        visit new_sub_category_path
   #       fill_in "Name", :with => 'Sub-category'
    #      # select category, how? 
     #   end.should change(SubCategory, :count).by(1)
      #end
    end
  end
end
