require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new(Store.first)
		# parser.update_category
		@status = get_category()
		# @status = parser.get_brand_name_by_category(parser.get_category.first)
	end
end
