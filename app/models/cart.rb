class Cart < ActiveRecord::Base
  has_many :line_items
#  has_one :order
  has_many :products, :through => :line_items
#  has_one :order_detail
#  has_one :shipping_address
  accepts_nested_attributes_for :line_items

  def total_price
    # to_a converts line items to a array so the sum is not done on the database
    Array(line_items).sum(&:full_price)
#.inject { |sum, n| sum + n.full_price } || 0
  end

  def total_items_in_cart
    Array(line_items).sum(&:quantity)
#.inject { |sum, n| sum + n.quantity } || 0
  end
end
