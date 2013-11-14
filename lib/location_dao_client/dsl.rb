module LocationDAOClient
  $last_location = nil

  def self.GETALL
    locations = Location.all
    locations.each do |l|
      puts l.to_s + ","
    end
  end

  def self.FINDBYNAME(pattern)
    locations = Location.where name: /^#{pattern}/i
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
      location = Location.find(id)
      puts location
      $last_location = location
    rescue
      puts "Location #{id} doesn't exist"
    end
  end

  def self.CREATE(*args)
    create_map = Hash[*args]
    location = Location.new create_map
    if location.save
      puts "Successfully create #{location}"
      $last_location = location
    else
      puts "\e[1mFail to create Location\e[0m"
      puts location.errors.full_messages.to_sentence
    end
  end

  def self.UPDATE(*args)
    id = args.shift
    id = $last_location._id if id == "last"
    update_map = Hash[*args]
    begin
      location = Location.find id
      location.update_attributes update_map
      puts location
      $last_location = location
    rescue
      puts "Location #{id} doesn't exist"
    end
  end

  def self.DELETE(id)
    id = $last_location._id if id == "last"
    begin
      location = Location.find id
      location.destroy
      puts "Successfully destroyed #{location}"
    rescue
      puts "Location #{id} doesn't exist"
    end
  end

  def self.method_missing(m, *args, &block)
    puts "Undefined action: #{m}"
  end
end
