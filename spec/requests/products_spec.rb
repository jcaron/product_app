require 'spec_helper'

describe "Products" do
  it "should have a products index" do
    get products_path
    response.status.should be(200)
  end

  describe "New" do
    describe "failure" do
      it 'should not make a new product' do
        lambda do
          visit new_product_path
          fill_in "Name", :with => ''
          click_button
          response.should render_template('products/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Product, :count)
      end
    end

    describe "success" do
#      it 'should make a new product with the correct sub-categories'
    end
  end
end
