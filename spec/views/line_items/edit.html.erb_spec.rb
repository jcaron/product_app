require 'spec_helper'

describe "line_items/edit" do
  before(:each) do
    @line_item = assign(:line_item, stub_model(LineItem,
      :cart_id => 1,
      :product_id => 1,
      :unit_price => "9.99",
      :quantity => 1
    ))
  end

  it "renders the edit line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => line_items_path(@line_item), :method => "post" do
      assert_select "input#line_item_cart_id", :name => "line_item[cart_id]"
      assert_select "input#line_item_product_id", :name => "line_item[product_id]"
      assert_select "input#line_item_unit_price", :name => "line_item[unit_price]"
      assert_select "input#line_item_quantity", :name => "line_item[quantity]"
    end
  end
end
