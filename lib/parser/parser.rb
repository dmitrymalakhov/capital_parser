require 'open-uri'

class Parser
	def initialize(store)
		@store = store
	end

	def get_status()
		return "OK"
	end
	def get_pavilion_by_store() 
		@store.pavilions
	end
	def get_category()
		@store.categories
	end

	def get_brands_by_category(category)
		category.brands
	end

	def update_category()
		doc = Nokogiri::HTML(open("#{@store.base_url}#{@store.pavilion_url}"))
		categories = doc.css("ul.cell_standart_struct1:has(.cell_standart_struct1 span)")
		category = categories.first
		# categories.each do |category|
			title = category.css("li.cell_standart_struct1 span.menuchilds").text
		    category_obj = @store.categories.where(:title => title).first_or_create	
			
			pavilions = category.css("a:not([href*='plan'])")
			pavilion = pavilions.first
			# pavilions.each do |pavilion|
				brand_obj = Brand.where(:title => pavilion.text).first_or_create
				pavilion_obj = category_obj.pavilions.where(:brand_id => brand_obj.id).first_or_create
				update_pavilion_description(pavilion_obj, pavilion['href'])
			# end
		# end
	end

	def update_pavilion_description(pavilion_obj, description_url)
		doc = Nokogiri::HTML(open("#{@store.base_url}#{description_url}"))
		puts "#{@store.base_url}#{description_url}"
		doc.xpath('//@style').remove
		pavilion = doc.css(".article .block_is")
		
		logo = pavilion.css("img.icon_standart").xpath('@src').text
		common = pavilion.css(".mag_is a")
		if !common[0].nil?
			floor = common[0].text
		end
		if !common[1].nil?
			site = common[1].xpath('@href').text
		end

		if pavilion_obj.pavilion_description.nil?  
			pavilion_obj.pavilion_description = PavilionDescription.new()
		end

		pavilion_obj.pavilion_description.update_attributes(:logo => logo, :floor => floor, :site => site)

		galery = doc.css(".highslide-gallery")
		galery.css("a.highslide").each do |slide|
			image = /.*\//.match slide.css("img").xpath('@src').text
			pavilion_obj.pavilion_gallery.where(:image => image[0]).first_or_create
		end

	end
end