module LocationDAOClient
  def self.GETALL
    Location.all.each do |l|
      puts l.to_s + ","
    end
  end

  def self.FINDBYNAME(pattern)
    locations = Location.where name: /^#{pattern}/
    if locations.count > 0
      locations.each do |l|
        puts l
      end
    else
      puts "No location found which starts with '#{pattern}'"
    end
  end

  def self.GET(id)
    begin
      l = Location.find(id)
      puts l
    rescue
      puts "Location #{id} doesn't exist"
    end
  end

  def self.CREATE(create_map)
    # TODO
  end

  def self.UPDATE(id, update_map)
    # TODO
  end

  def self.DELETE(id)
    # TODO
  end

  def self.method_missing(m, *args, &block)
    puts "Undefined action: #{m}"
  end
end
