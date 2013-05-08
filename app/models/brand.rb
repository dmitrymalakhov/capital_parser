class Brand < ActiveRecord::Base
	has_many :pavilions
	has_many :categories, :through => :pavilions
  	attr_accessible :title
end
