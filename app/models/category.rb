class Category < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :sub_categories, :dependent => :destroy
  has_many :products

  validates :name, :presence => true, :length => { :maximum => 50 }

  default_scope :order => 'categories.name'
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

