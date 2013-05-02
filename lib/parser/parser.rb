require 'open-uri'

class Parser
	def initialize(store)
		@store = store
	end

	def get_status()
		return "OK"
	end

	def get_category()
		doc = Nokogiri::HTML(open("#{@store.base_url}#{@store.pavilion}"))
		categories = doc.css("ul.cell_standart_struct1");

		categories.each do |category|
			title = category.css("li.cell_standart_struct1 .menuchilds").text
			# Category.create(:title => title.text, :store_id => store.id)
		end

		return "OK"
	end
end