class SubCategory < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :category
  has_many :relationships, :foreign_key => "sub_category_id", 
    :dependent => :destroy
  has_many :products, :through => :relationships

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :category_id, :presence => true
  validates_uniqueness_of :name, :scope => :category_id

  default_scope :order => 'sub_categories.name'
end

# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

