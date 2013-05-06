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

	def get_brand_name_by_category(category)
		category.brand_names
	end

	def update_category()
		doc = Nokogiri::HTML(open("#{@store.base_url}#{@store.pavilion_url}"))
		categories = doc.css("ul.cell_standart_struct1:has(.cell_standart_struct1 span)");
		# category = categories.first
		categories.each do |category|
			title = category.css("li.cell_standart_struct1 span.menuchilds").text
		    category_obj = @store.category.where(:title => title).first_or_create		
			
			pavilions = category.css("a:not([href*='plan'])")
			# pavilion = pavilions.first
			pavilions.each do |pavilion|
				brand_name_obj = category_obj.brand_names.where(:title => pavilion.text).first_or_create
				pavilion_obj = category_obj.pavilions.where(:brand_name_id => brand_name_obj.id).first_or_create
				# update_pavilion(pavilion_obj, pavilion['href'])
			end
		end

		return "OK"
	end

	# def update_pavilion(pavilion, description_url)
	# 	doc = Nokogiri::HTML(open("#{@store.base_url}#{description_url}"))
	# 	doc.xpath('//@style').remove
	# 	pavilion = doc.css(".article .block_is")
		
		# logo = pavilion.css("img.icon_standart").xpath('@src')
		# common = pavilion.css(".mag_is a")
		# floor = common[0]
		# site = common[1].xpath('@href')
		
	# end
end