# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'

class SFRParser < ParserBase

	def update_news()
		if @store.news_url.nil?
			return
		end

		@store.news_url.split(' ').each do |path| 

			doc = get_document("#{@store.base_url}#{path}")
			doc.css('.view_icon_div').remove
			# news = doc.css(".article tr.cell_standart_icon a.menuchilds").first
			doc.css(".article tr.cell_standart_icon a.menuchilds").each do |news|
				title = news.text
				link = news.xpath('@href').text
	
				article = get_document("#{@store.base_url}#{link}")
				content = article.css(".article .block_is")

				date = content.css(".header .date").text
				news_obj = @store.news.where(:title => title, :date_publication => date).first_or_initialize(:title => title, :date_publication => date, :site_url => path)

				if news_obj.new_record?
					content.css(".mess_standart img").each do |img|
						src = img.xpath('@src').text
						# puts news_obj.class
						news_obj.news_gallery.new(:image => src)
					end
					content.css('.mess_standart').search('img, hr').remove
					content.css('.header').remove

					news_obj.update_attributes(:content => content.css('.mess_standart').text)
					news_obj.save
				end
			end
		end
	end

	def update_category()

		if @store.pavilion_url.nil?
			return
		end

		@store.pavilion_url.split(' ').each do |path| 

			doc = get_document("#{@store.base_url}#{path}")
			doc.search("ul:has(li a[href*='plan'])").remove
			categories = doc.css("ul.cell_standart_struct1");

			# category = categories.first
			categories.each do |category|
				title = category.css("li.cell_standart_struct1").text
			    category_obj = @store.categories.where(:title => title).first_or_create

				pavilions = category.css("a")
				# pavilion = pavilions.first
				pavilions.each do |pavilion|
					brand_obj = Brand.where(:title => pavilion.text).first_or_create
					pavilion_obj = category_obj.pavilions.where(:brand_id => brand_obj.id).first_or_create
					update_pavilion_description(pavilion_obj, pavilion['href'])
				end
			end
		end
	end

	def update_pavilion_description(pavilion_obj, description_url)
		doc = get_document("#{@store.base_url}#{description_url}")

		puts "#{@store.base_url}#{description_url}"
		doc.xpath('//@style').remove
		pavilion = doc.css(".article .block_is")
		content = pavilion.css(".mess_standart")
		logo = pavilion.css("img.icon_standart").xpath('@src').text
		floor, site, phone = "-10", "", "-10"

		doc.css(".highslide-gallery a.highslide img").each do |slide|
			image = /.*\//.match slide.xpath('@src').text
			pavilion_obj.pavilion_gallery.where(:image => image[0]).first_or_create
		end

		doc.css(".mag_is tr").each do |info|
			case info.css("td:first").text
				when /расположение/i, /этаж/i
					temp = /\d/.match info.css("td:last").text
					if !temp.nil?
						floor = temp[0]
					end
				when /сайт/i
					site = info.css("td:last a").xpath('@href').text
				when /телефон/i
					phone = info.css("td:last").text
				when /принимаем к оплате/i
					info.css("td:last .mag_disc img").each do |card|
						image = card.xpath('@src').text
						name = card.xpath('@title').text

						credit = Credit.where(:image => image, :name => name).first_or_create
						if !pavilion_obj.credits.include?(credit)
							pavilion_obj.credits << credit
						end
					end
				when /скидки по картам/i, /дисконтные карты/i
					cards_type = info.css("td:last .mag_disc img")
					cards_discount = info.css("td:last .mag_disc_pro")

					cards = cards_type.zip(cards_discount)
					image, name, percentage = "", "", ""
					cards.each do |card|
						image = card.first.xpath('@src').text
						name = card.first.xpath('@title').text
						if !card.last.nil?
							temp = /.*?([\d]+).*/.match card.last.text #Проверить существование
							if !temp.nil?
								percentage = temp[1]
							end
						end

						discount = Discount.where(:image => image, :percentage => percentage, :name => name).first_or_create
						if !pavilion_obj.discounts.include?(discount)
							pavilion_obj.discounts << discount
						end
					end
			end
		end

		if pavilion_obj.pavilion_description.nil?
			pavilion_obj.pavilion_description = PavilionDescription.new()
		end

		content.search('img').remove
		content.css('.h-mag_is').remove
		content.css('.mag_is').remove



		pavilion_obj.pavilion_description.update_attributes(:logo => logo, :content => content.text, :floor => floor, :site => site, :phone => phone, :site_url => description_url)
	end
end