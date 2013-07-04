class Primitive
	attr_reader :x1, :x2, :y1, :y2, :c1, :c2, :type

	def initialize(node)
		@node = node
		@x1, @x2, @y1, @y2, @points = 0,0,0,0,0
		generate
	end

	def path(pos)
		case @type
			when "line"
				if pos == 0
					"M#{@x1},#{@y1}L#{@x2},#{@y2}"
				else
					"L#{@x2},#{@y2}"
				end
			when "polyline"
				"M#{@points.join("L")}"

			when "path"
				if pos == 0
					"M#{@x1},#{@y1}C#{@c1.join(",")},#{@c2.join(",")},#{@x2},#{@y2}"
				else
					"C#{@c1.join(",")},#{@c2.join(",")},#{@x2},#{@y2}"
				end
		end
	end

	def invert
		case @type
			when "line"
				@x1, @y1, @x2, @y2 = @x2, @y2, @x1, @y1
			when "polyline"
				@points = @points.reverse
			when "path"
				@x1, @y1, @x2, @y2 = @x2, @y2, @x1, @y1
		end
				
	end

	private
	def generate
		case @node.name
			when "line"
				@type = "line"
				@x1 = @node.xpath('@x1').to_s.to_f.round(3).to_s
				@y1 = @node.xpath('@y1').to_s.to_f.round(3).to_s
				@x2 = @node.xpath('@x2').to_s.to_f.round(3).to_s
				@y2 = @node.xpath('@y2').to_s.to_f.round(3).to_s

			when "polyline"
				@type = "polyline"
				@points = @node.xpath('@points').to_s.gsub("-", ",-").split(" ")
		

				begin_point = @points.first.split(",")
				end_point = @points.last.split(",")

				@x1 = begin_point[0].to_f.round(3).to_s
				@y1 = begin_point[1].to_f.round(3).to_s
				@x2 = end_point[0].to_f.round(3).to_s
				@y2 = end_point[1].to_f.round(3).to_s

			when "path"
				@type = "path"
				d = @node.xpath('@d').to_s.gsub("-", ",-")
				
				begin_point = d[d.index("M")+1..d.index("c")-1].split(",").map {|point| point.to_f}
				end_point = d[d.index("c")+1..d.length].split(",").map {|point| point.to_f}

				if end_point[0] == 0.0 
					end_point.delete(0)
				end

				@x1 = begin_point[0].round(3).to_s
				@y1 = begin_point[1].round(3).to_s
				@x2 = (end_point[4]+begin_point[0]).round(3).to_s
				@y2 = (end_point[5]+begin_point[1]).round(3).to_s
				@c1 = [end_point[0]+begin_point[0], end_point[1]+begin_point[1]]
				@c2 = [end_point[2]+begin_point[0], end_point[3]+begin_point[1]]

				# puts "x1 = #{@x1}, y1 = #{@y1}, end_point = #{end_point}, c1 = #{@c1}, c2 = #{@c2}"
		end
	end
end