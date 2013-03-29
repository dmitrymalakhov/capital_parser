require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("http://www.fantastika-nn.ru/?id=218"))

pavilions = doc.css(".list_table_cols a:not([href*='plan'])");

pavilions.each do |pavilion|
  puts "#{pavilion.text} - #{pavilion['href']}"
end