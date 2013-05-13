# encoding: utf-8
require 'open-uri'

class Parser
	def initialize(store)
		@store = store
	end

	def get_status()
		return "OK"
	end
	
	def get_categories()
		@store.categories
	end

	def get_pavilions_by_store()
		@store.pavilions
	end
	def get_pavilions_by_category(category)
		category.pavilions
	end
	def get_brands_by_category(category)
		category.brands
	end
	def get_description_by_pavilion(pavilion)
		pavilion.pavilion_description
	end

	def update_category()
		doc = get_document("#{@store.base_url}#{@store.pavilion_url}")

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
		doc = get_document("#{@store.base_url}#{description_url}")		

		puts "#{@store.base_url}#{description_url}"
		doc.xpath('//@style').remove
		pavilion = doc.css(".article .block_is")

		logo = pavilion.css("img.icon_standart").xpath('@src').text
		floor, site, phone = "", "", ""

		doc.css(".mag_is tr").each do |info|
			case info.css("td:first").text
				when /Расположение/
					floor = /\d/.match info.css("td:last").text
				when /Веб-сайт/
					site = info.css("td:last a").xpath('@href').text
				when /Телефон/
					phone = info.css("td:last").text
				when /Принимаем к оплате/
					info.css("td:last .mag_disc img").each do |card|
						image = card.xpath('@src').text
						name = card.xpath('@title').text

						credit = Credit.where(:image => image, :name => name).first_or_create
						if !pavilion_obj.credits.include?(credit)
							pavilion_obj.credits << credit
						end
					end
				when /Скидки по картам/
					info.css("td:last").each do |card|
						image = card.css(".mag_disc img").xpath('@src').text
						name = card.css(".mag_disc img").xpath('@title').text
						percentage = /\d/.match card.css(".mag_disc_pro").text #спросить у Димы как выделить скидку

						discount = Discount.where(:image => image, :percentage => percentage[0],:name => name).first_or_create
						if !pavilion_obj.discounts.include?(discount)
							pavilion_obj.discounts << discount
						end
					end

			end
		end

		if pavilion_obj.pavilion_description.nil?
			pavilion_obj.pavilion_description = PavilionDescription.new()
		end

		pavilion_obj.pavilion_description.update_attributes(:logo => logo, :floor => floor[0], :site => site, :phone => phone)

		doc.css(".highslide-gallery a.highslide img").each do |slide|
			image = /.*\//.match slide.xpath('@src').text
			pavilion_obj.pavilion_gallery.where(:image => image[0]).first_or_create
		end
	end

	private 

	def get_document(path)
		begin
			doc = Nokogiri::HTML(open(path))
		rescue Timeout::Error
			result = false
			puts "repeat query....."
		else
			result = true
		end while !result

		return doc
	end
end