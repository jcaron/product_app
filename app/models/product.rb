class Product < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :category
  has_many :relationships, :foreign_key => "product_id",
    :dependent => :destroy
  has_many :sub_categories, :through => :relationships,
    :source => :sub_category

  validates :name, :presence => true, :length => { :maximum => 50 }

  def has_sub_category?(sub_category)
    self.relationships.find_by_sub_category_id(sub_category)
  end

  def add_sub_category!(sub_category)
    unless has_sub_category?(sub_category)
      self.relationships.create!(:sub_category_id => sub_category.id)
    end
  end

  def set_category(id)
    self.category_id = id if self.category_id.nil?
  end
end
