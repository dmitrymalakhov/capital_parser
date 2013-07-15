class ContentController < ApplicationController
	def index
		@stores = Store.all
	end

end
