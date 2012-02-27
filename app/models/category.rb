class Category < ActiveRecord::Base
  attr_accessible :name, :description, :sub_categories_attributes

  has_many :sub_categories, :dependent => :destroy
  has_many :products

  accepts_nested_attributes_for :sub_categories, :allow_destroy => true

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_uniqueness_of :name, :case_sensitive => false

  default_scope :order => 'name asc'
end

# == Schema Information
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

