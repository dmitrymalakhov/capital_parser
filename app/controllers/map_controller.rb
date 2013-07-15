require 'parser/map_parser'

class MapController < ApplicationController
	def index

	end

	def viewer
		@regions = Store.find(params[:store]).regions.where(:floor => params[:floor])
		@store = Store.find(params[:store])
		@pavilions = Store.find(params[:store]).pavilions
	end

	def set_attr
		Region.find(params[:region]).update_attributes(:pavilion_id => params[:pavilion], :typemode => params[:typemode], :color => params[:color].empty? ? nil : params[:color] , :titlebox => "#{params[:titlebox_x]},#{params[:titlebox_y]},#{params[:titlebox_width]},#{params[:titlebox_height]}")
		redirect_to :action => "viewer", :store => 1, :floor => params[:floor]
	end

	def load
		parser = MapParser.new(Store.find(params[:store]))
		@content = parser.update
	end

	def get_regions
		@regions =  Store.find(params[:store]).regions.where(:floor => params[:floor])

	    response = @regions.map {|region|
	    	if !region.nil? 
	    		{
	    			:type => 'path', 
	    			:text => "OK",
	    			:path => region.path, 
	    			:font => region.to_json(:only => [:id,:pavilion_id,:color,:titlebox,:typemode]), 
	    			"stroke-width" => !region.pavilion.nil? ? "2" : "1", 
	    			:href => "#",
	    			:fill => 
	    				if region.typemode == 0 
	    					!region.color.nil? ? "#"+"#{region.color}" : "#ffffff"
	    				else
	    					"url(#{Typemode.find(region.typemode).image.url()})"
	    				end,
	    			:title => !region.pavilion.nil? ? region.pavilion.brand.title : "not pavilion"
	    		} 
	    	else
	    		nil 
	    	end
	    }

		respond_to do |format|
	      # format.html # index.html.erb
	      format.json { render json: response.compact }
	    end
	end
end
