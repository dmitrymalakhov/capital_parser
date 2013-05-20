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
				film.css("#film_title #film_title_formats").remove

				puts film_path
				film_title = film.css("#film_title").text
				film_engtitle = film.css("#film_engtitle").text
				
				genre, duration, in_theaters, production, producer, actors = "", "", "", "", "", ""
				film.css("#film_bits div").each do |bit|
					case bit.text
						when /жанр/i
							genre = bit.css("b").text
						when /длительность/i
							duration = bit.css("b").text
						when /в прокате/i
							in_theaters = bit.css("b").text
						when /производство/i
							production = bit.css("b").text
					end
				end

				film.css(".film_attrs").each do |attribute|
					case attribute.css(".film_attr_header").text
						when /режиссёр/i
							producer = attribute.css(".film_attr_data").text
						when /актёры/i
							actors = attribute.css(".film_attr_data").text
					end
				end
				Film.where(:title => film_title).first_or_create(:title => film_title, :engtitle => film_engtitle, :genre => genre, :duration => duration, :in_theaters => in_theaters, :production => production, :producer => producer, :actors => actors)		
			end
		end
	end
end