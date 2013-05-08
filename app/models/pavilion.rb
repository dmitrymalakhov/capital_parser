class Pavilion < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand
  has_one :store, :through => :categories
  has_one :pavilion_description
  has_many :pavilion_gallery
end
