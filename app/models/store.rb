class Store < ActiveRecord::Base
	has_many :categories
	has_many :news
	has_many :film_schedules
	has_many :regions
	has_many :typemodes
	has_many :pavilions
	has_many :pavilions, :through => :categories
	attr_accessible :base_url, :news_url, :pavilion_url, :services_url, :cinema_url, :title

	def cleanup
		self.categories.each do |category|
			category.pavilions.where('updated_at < ?', 60.days.ago).each do |pavilion|
		      pavilion.region.update_attributes(:pavilion_id => nil, :updated_at => Time.current)
		      pavilion.destroy
		    end
		end
	end
end
