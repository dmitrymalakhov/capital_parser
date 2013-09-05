# encoding: utf-8
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://www.etagi.ru/?id=226"))
doc.xpath('//@style').remove
doc.search('script').remove
doc.css('.view_icon_div').remove

news = doc.css(".block_is td.art_sect").first
# doc.css(".block_is td.art_sect").each do |news|
	date = news.css(".date").text	
	title = news.css("a.menunews").text
	path = news.css("a.menunews").xpath('@href').text

	# puts path
	article = Nokogiri::HTML(open("http://www.etagi.ru#{path}"))
	article.xpath('//@style').remove
	article.search('script').remove

	content = article.css(".block_is table[cellpadding='5']")
	# puts content
	content.css("img").each do |img|
		src = img.xpath('@src').text
		# puts "#{src}"
	end
	content.search('img, hr').remove
	text = content.text
	puts "#{text.squeeze('\t')}"

# end

 