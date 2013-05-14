# encoding: utf-8
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=201"))

doc.css(".article tr.cell_standart_icon .view_icon_div a.menuchilds").each do |news|
	title = news.css("img").xpath('@title')
	article = Nokogiri::HTML(open("http://fantastika-nn.ru#{news.xpath('@href').text}"))

	puts "#{article.css(".header .date").text} -> #{title}"
end