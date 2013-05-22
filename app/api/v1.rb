module API
  class V1 < Grape::API
  	format :json
  	prefix :api

    get :hello do
      { text: 'Hello from Twilio' }
    end
  end
end