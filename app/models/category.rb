class Category < ActiveRecord::Base
  belongs_to :store
  has_many :pavilions
  attr_accessible :title
  validates :title, :presence => true
end
