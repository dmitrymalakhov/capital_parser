require 'parser/sfr_parser'
require 'parser/cinema_parser'
require 'parser/e_parser'

class ParserController < ApplicationController
	layout "main"

	def status
		Store.where(:title => "Fantastika", :base_url => "http://www.fantastika-nn.ru", :pavilion_url => "/?id=218 /?id=240", :news_url => "/?id=201", :cinema_url => "http://www.cinemapark.ru/multiplexes/show/13").first_or_create
		# Store.where(:title => "Respublika", :base_url => "http://www.respublika-nn.ru", :pavilion_url => "/?id=202", :news_url => "/?id=229").first_or_create
		# Store.where(:title => "7sky", :base_url => "http://7nebonnov.ru", :pavilion_url => "/?id=227 /?id=226", :news_url => "/?id=201 /?id=234", :cinema_url => "http://www.cinemapark.ru/multiplexes/show/27").first_or_create
		# Store.where(:title => "Etagi", :base_url => "http://www.etagi.ru", :pavilion_url => "/?id=6964&oneblock=6964", :news_url => "/?id=226 /?id=227").first_or_create
		
		Store.find(:all).each do |store|
			s_parser = SFRParser.new(store)
			# c_parser = CinemaParser.new(store)

			# c_parser.update_schedule
			# s_parser.update_category()
			s_parser.update_news
		end

		# category = parser.get_categories.first
		# pavilion = parser.get_pavilions_by_category(category).first
		# @status = parser.get_description_by_pavilion(pavilion).floor
		# @status = parser.get_brand_name_by_category(parser.get_category.first)
		# @status = parser.get_news
		# @status = parser.get_categories
	end
end
