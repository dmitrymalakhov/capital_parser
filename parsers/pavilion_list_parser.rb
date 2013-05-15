require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=240"))

#pavilions = doc.css(".list_table_cols a:not([href*='plan'])");
categories = doc.css("ul.cell_standart_struct1:has(.cell_standart_struct1 span)");

categories.each do |category|
	title = category.css("li.cell_standart_struct1 span.menuchilds").text
	puts "[#{title}]"

	# pavilions = category.css("a:not([href*='plan'])")

	# pavilions.each do |pavilion|
	# 	puts "#{pavilion.text} - #{pavilion['href']}"
	# end
end