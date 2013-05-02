class Store < ActiveRecord::Base
	has_many :category
	attr_accessible :base_url, :news_url, :pavilion_url, :title
end
