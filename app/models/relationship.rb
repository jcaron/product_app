class Relationship < ActiveRecord::Base
  attr_accessible :sub_category_id

  belongs_to :sub_category
  belongs_to :product

  validates :sub_category_id, :presence => true
  validates :product_id, :presence => true

  after_destroy :destroy_lone_products
  before_save :check_product_category

  private
    def destroy_lone_products
      product.destroy if product.sub_categories.empty?
    end
    
    def check_product_category
      if product.category_id.nil?
        product.set_category sub_category.category_id
        product.save
      elsif product.category_id != sub_category.category_id
        return false
      end
    end
end
