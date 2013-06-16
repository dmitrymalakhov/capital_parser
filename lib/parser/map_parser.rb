# encoding: utf-8
require 'open-uri'
require 'parser/parser_base'
require 'parser/primitive'

class MapParser < ParserBase
	def update
		doc = get_xml("maps/#{@store.id}/1.xml")

		Dir.foreach("maps/#{@store.id}") {|file| 
			if file =~ /.xml/

				temp = /.*?([\d]+).*/.match  file
				floor = temp[1] 

				doc.css("g").each do |group|
					# group = doc.css("g").first
					
					items = group.xpath("*")
					
					primitives = items.map { |item| 
						Primitive.new(item)
					}

					path_closed, index = 0, 0

					puts primitives.count()
					until path_closed == primitives.count()-1					

						puts "#p = #{path_closed} - i = #{index+1}"
						puts "#{primitives[path_closed].x2} --- #{primitives[index+1].x1} --- #{primitives[path_closed].y2} --- #{primitives[index+1].y1}"
						if (primitives[path_closed].x2 == primitives[index+1].x1) and primitives[path_closed].y2 == primitives[index+1].y1
							primitives[path_closed+1], primitives[index+1] = primitives[index+1], primitives[path_closed+1]
							path_closed += 1
							index = path_closed
							puts "ok"
						elsif primitives[path_closed].x2 == primitives[index+1].x2 and primitives[path_closed].y2 == primitives[index+1].y2
							primitives[index+1].invert
							primitives[path_closed+1], primitives[index+1] = primitives[index+1], primitives[path_closed+1]
							path_closed += 1
							index = path_closed
							puts "revers ok"
						else
							index = index == primitives.count()-2 ? path_closed : index += 1
						end

						
					end

					d = ""
					path = primitives.each_with_index { |item, index|
						d += item.path(index)
					}
					
					d += "z"

					@store.regions.where(:path => d, :floor => floor).first_or_create
				end
			end 
		}
	end
end