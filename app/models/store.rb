class Store < ActiveRecord::Base
	has_many :categories
	has_many :news
	has_many :film_schedules
	has_many :pavilions
	has_many :pavilions, :through => :categories
	attr_accessible :base_url, :news_url, :pavilion_url, :services_url, :cinema_url, :title
end
