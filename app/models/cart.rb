class Cart < ActiveRecord::Base
  has_many :line_items
#  has_one :order
  has_many :products, :through => :line_items
#  has_one :order_detail
#  has_one :shipping_address
  accepts_nested_attributes_for :line_items

  after_save :check_items

  def total_price
    answer = 0
    line_items.each do |item|
      answer += item.full_price
    end
    answer
  end

  def total_items_in_cart
    answer = 0
    line_items.each do |item|
      answer += item.quantity
    end
    answer
  end

  private
    def check_items
      line_items.each do |item|
        item.destroy if item.quantity == 0
      end
    end
end
