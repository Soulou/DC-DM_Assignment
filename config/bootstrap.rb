require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

root_dir = File.dirname(__FILE__) + "/.."
# Load mongoid
Mongoid.load!("#{root_dir}/mongoid.yml")      

Dir.entries("#{root_dir}/models").each do |file|
  if file =~ /\.rb$/
    require "#{root_dir}/models/#{file}"
  end
end
