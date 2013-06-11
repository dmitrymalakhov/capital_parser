# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'

class MapParser < ParserBase
	def update
		doc = get_xml("maps/#{@store.id}/1.xml")

		Dir.foreach("maps/#{@store.id}") {|file| 
			if file =~ /.xml/

				temp = /.*?([\d]+).*/.match  file
				floor = temp[1] 

				doc.css("g").each do |group|
					# group = doc.css("g").last
					d = []	
					
					group.children.each_with_index do |item, index|
						case item.name
							when "line"
								if index = 0
									d.push("M#{item.xpath('@x1')},#{item.xpath('@y1')}L#{item.xpath('@x2')},#{item.xpath('@y2')}")
								else
									d.push("L#{item.xpath('@x2')},#{item.xpath('@y2')}")
								end
						end
					end
					
					d = d.join("")
					@store.regions.where(:path => d, :floor => floor).first_or_create
				end
			end 
		}
	end
end