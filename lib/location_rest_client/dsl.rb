module LocationRestClient
  $last_location = nil
  $base_url = nil

  def self.GETALL
    res = RestClient.get "#{$base_url}/locations", :accept => "application/json"
    locations_a = JSON.parse res
    locations = locations_a.map{ |l| location_from_hash l }

    locations.each do |l|
      puts l.to_s + ","
    end
  end

  def self.FINDBYNAME(pattern)
    res = RestClient.get "#{$base_url}/locations/search/#{pattern}", :accept => "application/json"
    locations_a = JSON.parse res
    locations = locations_a.map{ |l| location_from_hash l }

    if locations.count > 0
      locations.each do |l|
        puts l.to_s + ","
      end
    else
      puts "No location found which starts with '#{pattern}'"
    end
  end

  def self.GET(id)
    id = $last_location._id if id == "last"
    begin
      res = RestClient.get "#{$base_url}/locations/#{id}", :accept => "application/json"
      location = location_from_hash JSON.parse(res)
      puts location
      $last_location = location
    rescue => e
      puts "Error fetching #{id}: #{e}"
    end
  end

  def self.CREATE(*args)
    create_map = { :location => Hash[*args] }.to_json
    begin
      res = RestClient.post "#{$base_url}/locations", create_map, :accept => "application/json"
      if res.code == 201
        location = location_from_hash JSON.parse(res)
        puts location
      else
        puts "\e[1mInvalid resturn code from server #{res.code}\e[0m"
      end
    rescue => e
      puts "\e[1mFail to create Location\e[0m"
      puts "#{e}"
    end
  end

  def self.UPDATE(*args)
    id = args.shift
    id = $last_location._id if id == "last"
    update_map = { :location => Hash[*args] }.to_json
    begin
      res = RestClient.post "#{$base_url}/locations/#{id}", update_map, :accept => "application/json"
      if res.code == 200
        location = location_from_hash JSON.parse(res)
        puts location
      else
        puts "\e[1mInvalid resturn code from server #{res.code}\e[0m"
      end
    rescue => e
      puts "\e[1mFail to create Location\e[0m"
      puts "#{e}"
    end
  end

  def self.DELETE(id)
    id = $last_location._id if id == "last"
    begin
      res = RestClient.delete "#{$base_url}/locations/#{id}"
      if res.code == 204
        puts "Successfully destroyed #{id}"
      else
        puts "Invalid return code #{res.code}"
      end
    rescue => e
      puts "Fail to delete #{id}: #{e}"
    end
  end

  def self.method_missing(m, *args, &block)
    puts "Undefined action: #{m}"
  end

  private

  def self.location_from_hash(location_h)
    location_h["picture"] = nil
    l = Location.new location_h
    l.id = location_h["id"]
    return l
  end
end
