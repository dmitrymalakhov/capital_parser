require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new(Store.first)
		parser.update_category
		@status = parser.get_category
	end
end
