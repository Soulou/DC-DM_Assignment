module LocationsRest
  class Main < Sinatra::Base
    register Sinatra::RespondWith

    def respond_rabl(view, status_code = 200)
      status status_code
      respond_to do |f|
        f.json { rabl view }
        f.xml { rabl view, :format => :xml }
      end
      halt 406, {
        :error => "Only application/json and application/xml are allowed"
      }.to_json
    end

    get '/locations' do
      @locations = Location.all
      respond_rabl :index
    end

    get '/locations/:id' do
      begin
        @location = Location.find params[:id]
        respond_rabl :show
      rescue
        halt 404
      end
    end

    get '/locations/search/:name' do
      @locations = Location.where :name => /#{params[:name]}/
      respond_rabl :index
    end

    post '/locations' do
      if !params.has_key? "location"
        halt 400,  {:error => "Missing parameter 'location'" }.to_json
      end
      @location = Location.create params["location"]
      respond_rabl :show, 201
    end

    put '/locations/:id' do
      begin
        @location = Location.find params[:id]
        if !params.has_key? "location"
          halt 400,  {:error => "Missing parameter 'location'" }.to_json
        end
        @location.update_attributes params["location"]
        respond_rabl :show
      rescue
        halt 404
      end
    end

    delete '/locations/:id' do
      begin
        @location = Location.find(params[:id]).destroy
        halt 204
      rescue
        halt 404
      end
    end
  end
end
