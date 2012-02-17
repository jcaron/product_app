class Product < ActiveRecord::Base
  attr_accessor :sub_category_id
  attr_accessible :name, :description, :sub_category_id, :category_id

  belongs_to :category
  has_many :relationships, :foreign_key => "product_id",
    :dependent => :destroy
  has_many :sub_categories, :through => :relationships,
    :source => :sub_category
  has_many :line_items
  accepts_nested_attributes_for :sub_categories

  default_scope :order => 'products.name'

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_uniqueness_of :name, :scope => :category_id, :case_sensitive => false
  validates :category_id, :presence => true
  validates :sub_category_id, :presence => true
#  validates_numericality_of :unit_price, :greater_than_or_equal_to => 0  

  def has_sub_category?(sub_category)
    self.relationships.find_by_sub_category_id(sub_category)
  end

  def add_sub_category!(sub_category)
    unless has_sub_category?(sub_category)
      begin
        self.relationships.create!(:sub_category_id => sub_category)
      rescue ActiveRecord::RecordNotSaved
        logger.info "Failed to save relationship record, invalid input"
      end
    end
  end

  def set_category(id)
    self.category_id = id
  end
end

# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

