task :bootstrap do
  require File.dirname(__FILE__) + "/config/bootstrap.rb"
  Dir.entries(File.dirname(__FILE__) + "/lib/location_dao_client").each do |entry|
    require File.dirname(__FILE__) + "/lib/location_dao_client/#{entry}" if entry =~ /.*\.rb$/
  end
  Dir.entries(File.dirname(__FILE__) + "/lib/location_rest_client").each do |entry|
    require File.dirname(__FILE__) + "/lib/location_rest_client/#{entry}" if entry =~ /.*\.rb$/
  end
end

task :console => :bootstrap do
  # Open a console in the environment of the application
  binding.pry
end

namespace :db do
  desc "Manage database"
  task :seed => :bootstrap do
    require File.dirname(__FILE__) + "/db/seed.rb"
  end
end

namespace :daoclient do
  desc "Execute simple commands"
  task :exec => :bootstrap do
    if ARGV.length == 2
      LocationDAOClient.exec_from_file ARGV[1]
    elsif ARGV.length == 1
      LocationDAOClient.exec_from_stdin
    else
      puts "\e[1mUSAGE: rake #{ARGV[0]} [file]\e[0m"
    end
  end
end

namespace :restclient do
  desc "Execute simple commands get data from a REST API"
  task :exec => :bootstrap do
    if ARGV.length == 3
      LocationRestClient.exec_from_file ARGV[1], ARGV[2]
    elsif ARGV.length == 2
      LocationRestClient.exec_from_stdin ARGV[1]
    else
      puts "\e[1mUSAGE: rake #{ARGV[0]} <URL> [file]\e[0m"
    end
  end
end
