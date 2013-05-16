# encoding: utf-8
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=201"))
doc.xpath('//@style').remove
doc.search('script').remove

doc.css(".article tr.cell_standart_icon .view_icon_div a.menuchilds").each do |news|
	title = news.css("img").xpath('@title').text
	article = Nokogiri::HTML(open("http://fantastika-nn.ru#{news.xpath('@href').text}"))
	article.xpath('//@style').remove
	article.search('script').remove

	content = article.css(".article .block_is")

	date = content.css(".header .date").text
	puts "#{title} --- #{date}"

	content.css(".mess_standart img").each do |img|
		src = img.xpath('@src').text
		puts "#{src}"
	end
	content.css('.mess_standart').search('img, hr').remove
	content.css('.header').remove

	puts "#{content.text}"

end

 