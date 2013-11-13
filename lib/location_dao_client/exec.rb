module LocationDAOClient
  def self.exec_from_file(file)
    # TODO
    binding.pry
  end

  def self.exec_from_stdin
    ARGV.shift
    print "> "
    ARGF.each do |line|
      command = line.split " "
      if command.length == 0
        print "> "
        next
      end
      function = command.shift.strip

      begin
        if command.length == 0
          self.send(:"#{function}")
        else
          self.send(:"#{function}", *command)
        end
      rescue ArgumentError
        puts "Invalid arguments for #{function}"
      end
      print "> "
    end
  end
end
