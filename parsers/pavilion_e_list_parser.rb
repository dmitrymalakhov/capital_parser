# encoding: utf-8
require 'open-uri'
require 'nokogiri'

# doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=240"))
doc = Nokogiri::HTML(open("http://www.etagi.ru/?id=6964&oneblock=6964"))
# doc = Nokogiri::HTML(open("http://7nebonnov.ru/?id=227"))

#pavilions = doc.css(".list_table_cols a:not([href*='plan'])");
# doc.css("td.list_table_cols_one:has(ul li a[href*='plan'])").remove

positions = doc.css("tr.list_table_cols_one")

positions.each do |position|

	case position.search('div').count
		when 2
			puts position.css('.cell_alpha_1').text
			puts "------>"
			puts position.css('.cell_alpha_2 a').xpath('@href')
		when 1
			puts position.css('.cell_alpha_2 a').xpath('@href')
	end
	# title = category.css("li.cell_standart_struct1").text
	# puts "[#{title}]"

	# pavilions = category.css("a")

	# pavilions.each do |pavilion|
	# 	puts "#{pavilion.text} - #{pavilion['href']}"
	# end
end