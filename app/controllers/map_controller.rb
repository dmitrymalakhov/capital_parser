class MapController < ApplicationController
	def index

	end

	def viewer
		@regions = Store.find(params[:store]).regions
		@store = Store.find(params[:store])
		@pavilions = Store.find(params[:store]).pavilions
	end


	def set_attr
		redirect_to :action => "viewer", :store => 1
	end

	def get_regions
		@regions =  Store.find(params[:store]).regions

	    response = @regions.map {|region| !region.nil? ? {:type => 'path', :path => region.path, :font => "#{region.id}", "stroke-width" => "5", :href => "#", :title => !region.pavilion.nil? ? region.pavilion.brand.title : "not pavilion"} : nil }
	
		respond_to do |format|
	      # format.html # index.html.erb
	      format.json { render json: response.compact }
	    end
	end

	def get_pavilion_by_path
		@region =  Region.where('path LIKE ?', params[:path])
	    respond_to do |format|
	      # format.html # index.html.erb
	      format.json { render json: @region }
	    end
	end
end
