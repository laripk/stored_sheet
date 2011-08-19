require 'sinatra'
require 'mongoid'
require 'haml'

configure do
   Mongoid.load!("#{settings.root}/mongoid.yml")
   set :haml, :format => :html5
end

get '/' do
  haml :index, :locals => { :title => 'Welcome to the Stored Sheet Demo!' }
end


get '/shts' do
   sheets = Sheet.only(:sheet_name, :modified).desc(:modified)
   haml :sheets, :locals => { :title => 'All Sheets', :sheets => sheets }
end

