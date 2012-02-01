class Relationship < ActiveRecord::Base
  attr_accessible :sub_category_id

  belongs_to :sub_category
  belongs_to :product

  validates :sub_category_id, :presence => true
  validates :product_id, :presence => true
end
