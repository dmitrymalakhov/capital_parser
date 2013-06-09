class Pavilion < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand
  has_and_belongs_to_many :credits
  has_and_belongs_to_many :discounts
  has_one :store, :through => :categories
  has_one :pavilion_description
  has_many :pavilion_gallery
  has_one :region

  def brandname
  	self.brand.title
  end
end
