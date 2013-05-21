# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'

doc = Nokogiri::HTML(open("http://www.cinemapark.ru/multiplexes/show/27"), nil, 'UTF-8')
doc.xpath('//@style').remove
doc.search('script').remove

days = doc.css(".multiplex_schedule")
# day = days.first
days.each do |day|
	date = day.css(".multiplex_schedule_datelist a.current").xpath('@href').text.delete "#"
	date = Date.strptime(date, '%Y-%m-%d')
	puts "день - #{date.day} месяц - #{date.month} год - #{date.year}"

	schedule = day.css('.msch_group')

	schedule_auditoriums = schedule.css(".msch_hall_title")
	schedule_session = schedule.css(".msch_hall")

	schedule_configs = schedule_auditoriums.zip(schedule_session)

	schedule_configs.each do |config|
		
		option = config.first.css("div.hall_media_ndx").text
		config.first.css("div.hall_media_ndx").remove
		auditorium = config.first.css("a").text
		
		config.last.css("a").each do |item|
			time = item.css("b").text
			item.css("b").remove
			price = item.text
			puts "#{option} --- #{auditorium} --- #{time} --- #{price}"
		end
	end	
end
