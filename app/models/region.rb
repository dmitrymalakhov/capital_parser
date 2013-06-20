class Region < ActiveRecord::Base
	# self.inheritance_column = nil

  	belongs_to :pavilion
  	belongs_to :store
  	attr_accessible :pavilion_id, :store_id, :path, :floor, :color
end