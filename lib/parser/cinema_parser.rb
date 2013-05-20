# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'

class CinemaParser < ParserBase
	
	def update_schedule
		doc = get_document("#{@store.cinema_url}/multiplexes/show/27")
		days = doc.css(".multiplex_schedule")

		days.each do |day|
			date = day.css(".multiplex_schedule_datelist a.current").xpath('@href').text.delete "#"
			date = Date.strptime(date, '%Y-%m-%d')
			# puts "день - #{date.day} месяц - #{date.month} год - #{date.year}"

			schedules = day.css('.msch_group')
			schedules.each do |schedule|
				film_path = schedule.css('.msch_group_title a').xpath('@href')
				
				film = get_document("#{@store.cinema_url}#{film_path}")

				film_title = film.css(".film_title").text

				Film.where(:title => film_title).first_or_create(:title => film_title)		
			end
		end
	end
end