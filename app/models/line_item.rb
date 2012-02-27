class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  attr_accessible :quantity, :product_id, :cart_id

  validates_presence_of :product_id
  validates_presence_of :cart_id
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0
  validates_uniqueness_of :product_id, :scope => :cart_id

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
#  unit_price :decimal(, )     default(0.0)
#  quantity   :integer         default(1)
#  created_at :datetime
#  updated_at :datetime
#

