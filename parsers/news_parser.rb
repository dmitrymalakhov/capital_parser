# encoding: utf-8
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=201"))

# doc.css(".article tr.cell_standart_icon .view_icon_div a.menuchilds").each do |news|
# 	title = news.css("img").xpath('@title')
# 	article = Nokogiri::HTML(open("http://fantastika-nn.ru#{news.xpath('@href').text}"))

# 	puts article.css(".article").search('script, img, div.header').remove


# end

article = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=16449"))

content = article.css(".article .block_is .mess_standart")
content.search('script, img, hr').remove
content.xpath('//@style').remove

puts content


 