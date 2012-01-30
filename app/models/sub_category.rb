class SubCategory < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :category

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :category_id, :presence => true
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

