module LocationsRest
  class Main < Sinatra::Base
    # Set the app root
    set :root, File.dirname(__FILE__)

    register Sinatra::AssetPack
    register Sinatra::RespondWith

    assets do
      serve '/fonts',     from: 'app/fonts'
      js :application, ['/js/*.js']
      js :zepto, ['/js/vendor/zepto.min.js']
      js :bootstrap, ['/js/vendor/bootstrap.min.js']
      js :underscore, ['/js/vendor/underscore.js']
      css :application, ['/css/vendor/**/*.css', '/css/*.css']
    end

    helpers do
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

      def merge_json_body
        if request.content_type != "application/x-www-form-urlencoded"
          halt 400, {"error" => "Invalid parameters format"}.to_json
        end
        begin
          params.merge!(JSON.parse request.body.read)
        rescue JSON::ParserError
          halt 400, {"error" => "Invalid JSON"}.to_json
        end
      end
    end

    before '/locations' do
      next unless request.post?
      merge_json_body
    end
    before '/locations/:id' do |id|
      next unless request.put?
      merge_json_body
    end

    get '/' do
      haml :index
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
      @locations = Location.where :name => /^#{params[:name]}/i
      respond_rabl :index
    end

    post '/locations' do
      if !params.has_key? "location"
        halt 422,  {:error => "Missing parameter 'location'" }.to_json
      end
      @location = Location.new params["location"]
      if @location.save
        respond_rabl :show, 201
      else
        halt 422, {:error => @location.errors}.to_json
      end
    end

    put '/locations/:id' do
      begin
        @location = Location.find params[:id]
        if !params.has_key? "location"
          halt 422,  {:error => "Missing parameter 'location'" }.to_json
        end
        if @location.update_attributes params["location"]
          respond_rabl :show
        else
          halt 422, {:error => @location.errors}.to_json
        end
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
