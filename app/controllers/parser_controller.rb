require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new(Store.where(:title => "Fantastika", :base_url => "http://www.fantastika-nn.ru", :pavilion_url => "/?id=218", :news_url => "/?id=201").first_or_create)
		parser.update_category
		category = parser.get_categories.first
		pavilion = parser.get_pavilions_by_category(category).first
		@status = parser.get_description_by_pavilion(pavilion).floor
		# @status = parser.get_brand_name_by_category(parser.get_category.first)
	end
end
