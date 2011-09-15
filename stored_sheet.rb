require 'sinatra'
require 'mongoid'
require 'haml'
require 'coffee-script'
require './lib/sheet'

def setup_mongoid
   # puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"
   ENV['RACK_ENV'] = settings.environment.to_s
   # puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV']}"
   # puts "settings.root = #{settings.root}"
   Mongoid.load!("#{settings.root}/config/mongoid.yml")
end

configure do
   setup_mongoid
   set :haml, :format => :html5
end

get '/' do
   haml :index, :locals => { :title => 'Welcome to the Stored Sheet Demo!' }
end

get '/shts' do
   sheets = Sheet.only(:sheet_name, :id, :updated_at).desc(:updated_at)
   haml :sheets, :locals => { :title => 'All Sheets', :sheets => sheets }
end

def new_sheet name="Untitled"
   cols = Column.add_cols([], 3)
   sheet = Sheet.new(sheet_name: name, 
                     columns: cols, 
                     rows: [{},{},{}])
end

get '/shts/new' do
   sheet = new_sheet
   if sheet.save 
      redirect to("/shts/#{sheet.id}")
   else
      raise "new sheet save error"
   end
end

get '/shts/:id' do |id|
   sheet = Sheet.find(id)
   haml :sheet, :locals => { :title => 'View Sheet', :sheet => sheet }
end

