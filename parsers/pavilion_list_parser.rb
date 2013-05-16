require 'open-uri'
require 'nokogiri'

# doc = Nokogiri::HTML(open("http://fantastika-nn.ru/?id=240"))
doc = Nokogiri::HTML(open("http://7nebonnov.ru/?id=227"))

#pavilions = doc.css(".list_table_cols a:not([href*='plan'])");
# doc.css("td.list_table_cols_one:has(ul li a[href*='plan'])").remove
doc.search("ul:has(li a[href*='plan'])").remove
categories = doc.css("ul.cell_standart_struct1");

categories.each do |category|
	title = category.css("li.cell_standart_struct1").text
	puts "[#{title}]"

	pavilions = category.css("a")

	pavilions.each do |pavilion|
		puts "#{pavilion.text} - #{pavilion['href']}"
	end
end