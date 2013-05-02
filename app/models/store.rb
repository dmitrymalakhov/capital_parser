class Store < ActiveRecord::Base
	has_many :category
	attr_accessible :base_url, :news, :pavilion, :title
end
