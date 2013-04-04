require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://www.etagi.ru/Podium_Elite"))

doc.xpath('//@style').remove

pavilion = doc.css(".article .block_is .mess_standart")
galery = doc.css(".highslide-gallery")

title = pavilion.css(".header").text
floor = pavilion.css(".mag_is__mag_floor .clrowodd:last").text
site = pavilion.css(".mag_is__mag_web a").xpath('@href')
discount_imgs = pavilion.css(".mag_is__mag_disc img").xpath('@src')
card_img = pavilion.css(".mag_is__mag_card img").xpath('@src')
logo = pavilion.css("img.icon_standart").xpath('@src')

pavilion.xpath("//*[@class='h-mag_is']").remove
pavilion.xpath("//img").remove
content = pavilion

galery.css("a.highslide").each do |slide|
	#puts "#{slide['href']} >>> #{slide.css("img").xpath('@src')}"
end

puts discount_imgs