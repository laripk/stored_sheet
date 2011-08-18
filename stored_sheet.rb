require 'sinatra'
require 'mongoid'

configure do
   Mongoid.load!("#{settings.root}/mongoid.yml")
end

get '/' do
  "Hello World!"
end


