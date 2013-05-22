module API
  class API < Grape::API
  	format :xml
  	prefix :api
  	
    version :v2, :strict => false do
      get :hello do
        Category.all
      end
    end

  	version :v1 do
    	get :hello do
       	Store.all
      end
    end
  end
end