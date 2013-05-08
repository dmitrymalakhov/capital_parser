class Store < ActiveRecord::Base
	has_many :categories
	has_many :pavilions
	has_many :pavilions, :through => :categories
	attr_accessible :base_url, :news_url, :pavilion_url, :title
end
