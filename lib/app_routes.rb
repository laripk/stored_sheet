
get '/' do
   haml :index, :locals => { :title => 'Welcome to the Stored Sheet Demo!' }
end

get '/shts' do
   sheets = Sheet.only(:sheet_name, :id, :updated_at).desc(:updated_at)
   haml :sheets, :locals => { :title => 'All Sheets', :sheets => sheets }
end

get '/shts/new' do
   sheet = Sheet.new_sheet
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

post '/shts/:id' do |id|
   sheet = Sheet.find(id)
   request.body.rewind
   passedin = request.request_method + request.body.read
   sheet.update_attributes!(params)
   sheet2 = Sheet.find(id)
   haml :plain, :locals => { :title => 'Debug Sheet', :stuff => passedin.to_s, :sheet => sheet2 }
end


