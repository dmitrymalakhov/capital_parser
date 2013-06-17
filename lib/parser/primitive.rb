class Primitive
	attr_reader :x1, :x2, :y1, :y2, :type

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
		end
	end

	def invert
		case @type
			when "line"
				@x1, @y1, @x2, @y2 = @x2, @y2, @x1, @y1
			when "polyline"
				@points = @points.reverse
		end
				
	end

	private
	def generate
		case @node.name
			when "line"
				@type = "line"
				@x1 = @node.xpath('@x1').to_s
				@y1 = @node.xpath('@y1').to_s
				@x2 = @node.xpath('@x2').to_s
				@y2 = @node.xpath('@y2').to_s

			when "polyline"
				@type = "polyline"
				@points = @node.xpath('@points').to_s.split(" ")
		

				begin_point = @points.first.split(",")
				end_point = @points.last.split(",")

				@x1 = begin_point[0]
				@y1 = begin_point[1]
				@x2 = end_point[0]
				@y2 = end_point[1]
		end
	end
end