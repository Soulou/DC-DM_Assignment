module LocationRestClient
  def self.exec_from_file(url, file)
    $base_url = url
    File.read(file).split("\n").each do |line|
      puts "\e[1m#{line}\e[0m"
      self.eval_line line
    end
  end

  def self.exec_from_stdin(url)
    $base_url = url
    ARGV.shift
    while line = Readline.readline("> ", true)
      self.eval_line line
    end
  end

  private

  def self.eval_line(line)
    command = line.split " "
    if command.length == 0
      return
    end
    function = command.shift.strip
    command = command.join(" ").split(",").map{|arg| arg.strip}.map{|arg| arg.delete("\'\"")}

    begin
      if command.length == 0
        self.send(:"#{function}")
      else
        self.send(:"#{function}", *command)
      end
    rescue ArgumentError
      puts "Invalid arguments for #{function}"
    end
  end
end
