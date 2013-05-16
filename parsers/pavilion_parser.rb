# encoding: utf-8
require 'open-uri'
require 'nokogiri'

# doc = Nokogiri::HTML(open("http://www.fantastika-nn.ru/Accessorize"))
doc = Nokogiri::HTML(open("http://www.respublika-nn.ru/WhatTime"))
# doc = Nokogiri::HTML(open("http://7nebonnov.ru/?id=694"))

doc.xpath('//@style').remove

pavilion = doc.css(".article .block_is")
content = pavilion.css(".mess_standart")
logo = pavilion.css("img.icon_standart").xpath('@src').text
floor, site, phone = "", "", ""
# puts logo

# doc.css(".highslide-gallery a.highslide img").each do |slide|
# 	image = /.*\//.match slide.xpath('@src').text
# 	puts "#{image[0]}"
# end

# info = doc.css(".mag_is tr")
# puts info
# doc.css(".mag_is tr").each do |info|
# 	# puts info
# 	case info.css("td:first").text
# 		when /расположение/i, /этаж/i
# 			temp = /\d/.match info.css("td:last").text
# 			if !temp.nil?
# 				floor = temp[0]
# 			end
# 			puts floor
# 		when /сайт/i
# 			site = info.css("td:last a").xpath('@href').text
# 			puts site
# 		when /телефон/i
# 			phone = info.css("td:last").text
# 			puts phone
# 		when /принимаем к оплате/i
# 			info.css("td:last .mag_disc img").each do |card|
# 				image = card.xpath('@src').text
# 				name = card.xpath('@title').text

# 				puts "#{image} --- #{name}"
# 			end
# 		when /скидки по картам/i, /дисконтные карты/i
# 			cards_type = info.css("td:last .mag_disc img")
# 			cards_discount = info.css("td:last .mag_disc_pro")
			
# 			cards = cards_type.zip(cards_discount)

# 			cards.each do |card|
# 				image = card.first.xpath('@src').text
# 				name = card.first.xpath('@title').text

# 					temp = /.*?([\d]+).*/.match card.last.text #Проверить существование
# 					if !temp.nil?
# 						percentage = temp[1]
# 					end
# 				puts "#{image} --- #{name} --- #{percentage}"
# 			end
# 	end
# end

content.search('img').remove
content.css('.h-mag_is').remove
content.css('.mag_is').remove

puts content