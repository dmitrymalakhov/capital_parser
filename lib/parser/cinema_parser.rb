# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'

class CinemaParser < ParserBase
	
	def update_schedule
		doc = get_document("#{@store.cinema_url}/multiplexes/show/27")
		days = doc.css(".multiplex_schedule")
		# day = days.first
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
				film_poster = film.css("img#film_poster").xpath("@src").text
				film_content = film.css("div#film_description").text

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
				film_obj = Film.where(:title => film_title).first_or_create(:title => film_title, :content => film_content, :poster => film_poster, :engtitle => film_engtitle, :genre => genre, :duration => duration, :in_theaters => in_theaters, :production => production, :producer => producer, :actors => actors)		

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
						
						temp = /.*?([\d]+).*/.match item.text

						if !temp.nil?
							price = temp[1]
						end

						@store.film_schedules.where(:day => date.day, :month => date.month, :year => date.year, :time => time).first_or_create(:film_id => film_obj.id, :option => option, :auditorium => auditorium, :time => time, :price => price, :day => date.day, :month => date.month, :year => date.year)
						# puts "[#{film_title}] #{option} --- #{auditorium} --- #{time} --- #{price}"
					end
				end	
			end
		end
	end
end