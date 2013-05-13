class Discount < ActiveRecord::Base
	has_and_belongs_to_many :pavilions
  	attr_accessible :image, :name, :percentage
end
