require 'parser/parser'

class ParserController < ApplicationController
	layout "main"

	def status
		parser = Parser.new
		@status = parser.get_category()
	end
end
