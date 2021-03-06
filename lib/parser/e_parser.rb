# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'

class EParser < ParserBase

	def update_news()
		if @store.news_url.nil?
			return
		end

		@store.news_url.split(' ').each do |path| 

			doc = get_document("#{@store.base_url}#{path}")
			doc.css('.view_icon_div').remove
			doc.css(".block_is td.art_sect").each do |news|
				date = news.css(".date").text	
				title = news.css("a.menunews").text
				path = news.css("a.menunews").xpath('@href').text

				news_obj = @store.news.where(:title => title, :date_publication => date).first_or_create(:title => title, :date_publication => date, :site_url => path)
				
					article = get_document("#{@store.base_url}#{path}")

					content = article.css(".block_is table[cellpadding='5']")

					content.css("img").each do |img|
						src = img.xpath('@src').text 
						if src.match(Regexp.new(/^\//))
							news_obj.news_gallery.where(:image => src).first_or_create
						end
					end
					
					content.search('img, hr').remove

					news_obj.update_attributes(:content => beauty_string(content.text))
				if news_obj.new_record?
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
			
			positions = doc.css("tr.list_table_cols_one")

			category_obj = nil
			# position = positions.first
			positions.each do |position|
				case position.search('div').count
					when 2
						title = position.css('.cell_alpha_1').text
						if !title.blank?
							category_obj = @store.categories.where(:title => title).first_or_create
						end
						if !category_obj.nil?
							pavilion = position.css('.cell_alpha_2 a')

							brand_obj = Brand.where(:title => pavilion.text).first_or_create
							pavilion_obj = category_obj.pavilions.where(:brand_id => brand_obj.id).first_or_create
							update_pavilion_description(pavilion_obj, pavilion.xpath('@href').text)
						end
					when 1
						if !category_obj.nil?
							pavilion = position.css('.cell_alpha_2 a')

							brand_obj = Brand.where(:title => pavilion.text).first_or_create
							pavilion_obj = category_obj.pavilions.where(:brand_id => brand_obj.id).first_or_create
							update_pavilion_description(pavilion_obj, pavilion.xpath('@href').text)
						end
				end
			end
		end
	end

	def update_pavilion_description(pavilion_obj, description_url)
		doc = get_document("#{@store.base_url}#{description_url}")

		puts "#{@store.base_url}#{description_url}"
		content = doc.css(".block_is table[cellpadding='5']")
		
		logo = content.css("img.icon_standart").xpath('@src').text
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
				when /принимаем к оплате/i, /формы оплаты/i
					info.css("td:last .sect_disc img").each do |card|
						image = card.xpath('@src').text
						name = card.xpath('@title').text

						credit = Credit.where(:image => image, :name => name).first_or_create
						if !pavilion_obj.credits.include?(credit)
							pavilion_obj.credits << credit
						end
					end
				when /скидки по картам/i, /дисконтные карты/i
					cards_type = info.css("td:last .sect_disc img")
					cards_discount = info.css("td:last .sect_disc_pro")

					cards = cards_type.zip(cards_discount)
					image, name, percentage = "", "", ""
					cards.each do |card|
						image = card.first.xpath('@src').text
						name = card.first.xpath('@title').text
						if !card.last.nil?
							temp = /.*?([\d]+).*/.match card.last.text
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
		
		collection = content.css('.b-collection-wrap')

		content.search('img').remove
		content.css('.h-mag_is').remove
		content.css('.mag_is').remove
		content.css('.b-collection-wrap').remove
		
		collection_title = collection.css("h2").text
		collection.css("h2").remove

		content_compile = beauty_string(content.text) + "\n" + collection_title + "\n" + collection.text

		#!!!! error get content
		pavilion_obj.pavilion_description.update_attributes(:logo => logo, :content => content_compile, :floor => floor, :site => site, :phone => phone, :site_url => description_url)
	end
end