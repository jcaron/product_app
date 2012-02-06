class Product < ActiveRecord::Base
  attr_accessor :sub_category_id
  attr_accessible :name, :description

  belongs_to :category
  has_many :relationships, :foreign_key => "product_id",
    :dependent => :destroy
  has_many :sub_categories, :through => :relationships,
    :source => :sub_category
  accepts_nested_attributes_for :sub_categories

  default_scope :order => 'products.name'

  validates :name, :presence => true, :length => { :maximum => 50 }

  def has_sub_category?(sub_category)
    self.relationships.find_by_sub_category_id(sub_category)
  end

  def add_sub_category!(sub_category)
    unless has_sub_category?(sub_category)
      begin
        self.relationships.create!(:sub_category_id => sub_category.id)
      rescue ActiveRecord::RecordNotSaved
        logger.info "Failed to save relationship record, invalid input"
      end
    end
  end

  def set_category(id)
    self.category_id = id
  end
end
