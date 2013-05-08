class PavilionDescription < ActiveRecord::Base
	attr_accessible :content, :floor, :logo, :site

	has_one :pavilion
end
