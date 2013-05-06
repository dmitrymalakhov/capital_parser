class BrandName < ActiveRecord::Base
	has_many :pavilions
	has_many :categories, :through => :pavilions, :foreign_key => :category_id
  	attr_accessible :title
end
