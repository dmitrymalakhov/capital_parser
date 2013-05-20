# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'

doc = Nokogiri::HTML(open("http://www.cinemapark.ru/multiplexes/show/27"), nil, 'UTF-8')
doc.xpath('//@style').remove
doc.search('script').remove

days = doc.css(".multiplex_schedule")

days.each do |day|
	date = day.css(".multiplex_schedule_datelist a.current").xpath('@href').text.delete "#"
	date = Date.strptime(date, '%Y-%m-%d')
	puts "день - #{date.day} месяц - #{date.month} год - #{date.year}"

	schedule = day.css('.msch_group')

	film_path = schedule.css('.msch_group_title a').xpath('@href')
	
	film = Nokogiri::HTML(open("http://www.cinemapark.ru#{film_path}"), nil, 'UTF-8')

	
end
