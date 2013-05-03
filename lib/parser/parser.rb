require 'open-uri'

class Parser
	def initialize(store)
		@store = store
	end

	def get_status()
		return "OK"
	end

	def get_category()
		@store.category
	end

	def update_category()
		doc = Nokogiri::HTML(open("#{@store.base_url}#{@store.pavilion_url}"))
		categories = doc.css("ul.cell_standart_struct1:has(.cell_standart_struct1 span)");

		categories.each do |category|
			title = category.css("li.cell_standart_struct1 span.menuchilds").text
			@store.category.where(:title => title).first_or_create		
		end

		return "OK"
	end
end