require File.dirname(__FILE__) + "/config/bootstrap.rb"
require File.dirname(__FILE__) + "/main.rb"
 
map '/' do
  run LocationsRest::Main
end
