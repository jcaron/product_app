class Cart < ActiveRecord::Base
  attr_accessible :line_items_attributes
  has_many :line_items, :dependent => :destroy
  has_many :products, :through => :line_items

  belongs_to :user
#  has_one :order
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

=begin
  def current_cart
    if user_signed_in?
      user = current_user
      if user.cart.nil?
        user.cart.create()
        user.save
      end
      @current_cart = user.cart
    else
      session[:cart_id] ||= Cart.create!.id
    end
    @current_cart ||= Cart.find_or_create_by_id(session[:cart_id])
  end
=end

  private
    def check_items
      line_items.each do |item|
        item.destroy if item.quantity == 0
      end
    end
end

# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  order_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

