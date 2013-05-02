require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new(Store.first)
		@status = parser.get_category
	end
end
