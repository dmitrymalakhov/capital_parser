# encoding: utf-8
require 'open-uri'
require 'nokogiri'

# doc = Nokogiri::HTML(open("http://www.fantastika-nn.ru/Accessorize"))
doc = Nokogiri::HTML(open("http://7nebonnov.ru/?id=694"))

doc.xpath('//@style').remove

pavilion = doc.css(".article .block_is")
content = pavilion.css(".mess_standart")
logo = pavilion.css("img.icon_standart").xpath('@src').text
floor, site, phone = "", "", ""

doc.css(".highslide-gallery a.highslide img").each do |slide|
	image = /.*\//.match slide.xpath('@src').text
	puts "#{image[0]}"
end

doc.css(".mag_is tr").each do |info|
	case info.css("td:first").text
		when /Расположение/
			temp = /\d/.match info.css("td:last").text
			if !temp.nil?
				floor = temp[0]
			end
		when /Веб-сайт/
			site = info.css("td:last a").xpath('@href').text
		when /Телефон/
			phone = info.css("td:last").text
		when /Принимаем к оплате/
			info.css("td:last .mag_disc img").each do |card|
				image = card.xpath('@src').text
				name = card.xpath('@title').text

				puts "#{image} --- #{name}"
			end
		when /Скидки по картам/
			info.css("td:last").each do |card|
				image = card.css(".mag_disc img").xpath('@src').text
				name = card.css(".mag_disc img").xpath('@title').text

					temp = /.*?([\d]+).*/.match card.css(".mag_disc_pro").text #Проверить существование
					if !temp.nil?
						percentage = temp[1]
					end
				puts "#{image} --- #{name} --- #{percentage}"			
			end
	end
end

content.search('img').remove
content.css('.h-mag_is').remove

puts content