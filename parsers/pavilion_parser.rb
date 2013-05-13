# encoding: utf-8
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://www.fantastika-nn.ru/Accessorize"))

doc.xpath('//@style').remove

# pavilion = doc.css(".article .block_is")
galery = doc.css(".highslide-gallery")

# doc.css(".mag_is tr").each do |info|
# 	case info.css("td:first").text
# 		when /Расположение/
# 			puts info.css("td:last").text.scan(/\d/)
# 		when /Веб-сайт/
# 			puts info.css("td:last a").xpath('@href')
# 		when /Телефон/
# 			puts info.css("td:last").text
# 	end
# end

# title = pavilion.css(".header").text
# floor = pavilion.css(".mag_is a")
# puts floor[0].text
# site = pavilion.css(".mag_is__mag_web a").xpath('@href')

# discount_imgs = pavilion.css(".mag_is__mag_disc img").xpath('@src')
# card_img = pavilion.css(".mag_is__mag_card img").xpath('@src')
# logo = pavilion.css(".mess_standart img.icon_standart").xpath('@src')

# pavilion.xpath("//*[@class='h-mag_is']").remove
# pavilion.xpath("//img").remove
# content = pavilion

galery.css("a.highslide").each do |slide|
	image = /.*\//.match slide.css("img").xpath('@src').text
	puts image[0]
end
