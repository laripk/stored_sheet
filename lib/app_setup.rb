require 'mongoid'
require 'haml'
require 'coffee-script'
require './lib/coffee-haml-filter/lib/haml/filters/coffee'
require './lib/sheet'

def setup_mongoid
   # puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"
   ENV['RACK_ENV'] = settings.environment.to_s
   # puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"
   # puts "settings.root = #{settings.root}"
   # NOTE settings.root is determined by where require 'sinatra' happens
   Mongoid.load!("#{settings.root}/config/mongoid.yml")
end

configure do
   setup_mongoid
   set :haml, :format => :html5
end