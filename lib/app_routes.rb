
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

put '/shts/:id' do |id|
   sheet = Sheet.find(id)
   request.body.rewind
   passedin = params.inspect + "<br/>" + request.request_method + "<br/>" + request.body.read
   sheet.update_attributes!(JSON.parse(params[:model]))
   sheet2 = Sheet.find(id)
   # if request.xhr?
   #    fix_sheet_for_clientside sheet2
   # else
      haml :plain, locals: { title: 'Debug Sheet', stuff: passedin.to_s, sheet: sheet2 }
   # end
end

# put '/shts/4e810928673a5265a0000004' do 
#    "Hello World" 
# end
