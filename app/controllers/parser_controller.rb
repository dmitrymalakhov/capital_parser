require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new(Store.where(:title => "Fantastika", :base_url => "http://www.fantastika-nn.ru", :pavilion_url => "/?id=218", :news_url => "/?id=201").first_or_create)
		@status = parser.update_category
		# @status = parser.get_pavilion_by_store()
		# @status = parser.get_brand_name_by_category(parser.get_category.first)
	end
end
