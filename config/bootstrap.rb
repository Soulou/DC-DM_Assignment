require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
Encoding.default_external = Encoding::UTF_8
require 'sinatra/respond_with'

root_dir = File.dirname(__FILE__) + "/.."
# Load mongoid
Mongoid.load!("#{root_dir}/config/mongoid.yml")

Dir.entries("#{root_dir}/models").each do |file|
  if file =~ /\.rb$/
    require "#{root_dir}/models/#{file}"
  end
end

class PrettyJson
  def self.dump(object)
    JSON.pretty_generate(object, {:indent => "  "})
  end
end
Rabl.configure do |config|
  config.json_engine = PrettyJson
  config.include_json_root = false
  config.include_child_root = false
end
Rabl.register!
