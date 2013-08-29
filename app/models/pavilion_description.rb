class PavilionDescription < ActiveRecord::Base
	attr_accessible :content, :floor, :logo, :site, :phone, :site_url

	has_one :pavilion
end
