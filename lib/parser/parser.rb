require 'open-uri'

class Parser
	def initialize()
		@doc = Nokogiri::HTML(open("http://www.respublika-nn.ru/?id=202"))
	end

	def get_status()
		return "OK2"
	end

	def get_category()

		categories = @doc.css("ul.cell_standart_struct1");

		categories.each do |category|
			title = category.css("li.cell_standart_struct1 .menuchilds").text
		end

		return categories.text
	end
end