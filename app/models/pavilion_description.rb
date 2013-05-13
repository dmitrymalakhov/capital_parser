class PavilionDescription < ActiveRecord::Base
	attr_accessible :content, :floor, :logo, :site, :phone

	has_one :pavilion
end
