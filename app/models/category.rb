class Category < ActiveRecord::Base
  belongs_to :store
  has_many :pavilions
  has_many :brand_names, :through => :pavilions, :foreign_key => :brand_name_id
  attr_accessible :title
  validates :title, :presence => true
end
