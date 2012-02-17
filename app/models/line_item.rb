class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  attr_accessible :quantity, :unit_price, :product_id, :cart_id

  validates_presence_of :product_id
  validates_presence_of :cart_id

  def unit_price
    product.unit_price
  end

  def full_price
    unit_price * quantity
  end
end

# == Schema Information
#
# Table name: line_items
#
#  id         :integer         not null, primary key
#  cart_id    :integer
#  product_id :integer
#  unit_price :decimal(10, 2)
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

