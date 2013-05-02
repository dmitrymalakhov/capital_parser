class Category < ActiveRecord::Base
  belongs_to :store
  attr_accessible :title
  validates :title, :presence => true
end
