class Product < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :relationships, :foreign_key => "product_id",
    :dependent => :destroy
  has_many :sub_categories, :through => :relationships,
    :source => :sub_category

  validates :name, :presence => true, :length => { :maximum => 50 }
end
