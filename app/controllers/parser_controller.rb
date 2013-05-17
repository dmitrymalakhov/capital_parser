require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		# parser = Parser.new(Store.where(:title => "Fantastika", :base_url => "http://www.fantastika-nn.ru", :pavilion_url => "/?id=218", :services_url => "/?id=240", :news_url => "/?id=201").first_or_create)
		# parser = Parser.new(Store.where(:title => "Respublika", :base_url => "http://www.respublika-nn.ru", :pavilion_url => "/?id=202", :news_url => "/?id=229").first_or_create)
		parser = Parser.new(Store.where(:title => "7sky", :base_url => "http://7nebonnov.ru", :pavilion_url => "/?id=227", :services_url => "/?id=226", :news_url => "/?id=201").first_or_create)
		# parser = Parser.new(Store.where(:title => "Etagi", :base_url => "http://www.etagi.ru", :pavilion_url => "/?id=209", :news_url => "/?id=226").first_or_create)


		parser.update_category('pavilions')
		parser.update_category('services')
		parser.update_news
		# category = parser.get_categories.first
		# pavilion = parser.get_pavilions_by_category(category).first
		# @status = parser.get_description_by_pavilion(pavilion).floor
		# @status = parser.get_brand_name_by_category(parser.get_category.first)
		# @status = parser.get_news
	end
end
