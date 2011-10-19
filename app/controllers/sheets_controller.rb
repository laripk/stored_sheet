class SheetsController < ApplicationController
   def index
     sheets = Sheet.only(:sheet_name, :id, :updated_at).desc(:updated_at)
     @title = 'All Sheets'
     @sheets = sheets
   end

   def new
     sheet = Sheet.new_sheet
     if sheet.save 
        redirect_to "/sheets/#{sheet.id}"
     else
        raise "new sheet save error"
     end
   end

   def show
     sheet = Sheet.find(params[:id])
     @title = 'View Sheet'
     @sheet = sheet
   end

   def update
     sheet = Sheet.find(params[:id])
   # puts params
     # request.body.rewind
     # passedin = params.inspect + "<br/>" + request.request_method + "<br/>" + request.body.read
     sheet.update_attributes!(params[:sheet]) # JSON.parse()
     sheet2 = Sheet.find(params[:id])
     # if request.xhr?
        fix_sheet_for_clientside sheet2
     # else
     #    haml :plain, locals: { title: 'Debug Sheet', stuff: passedin.to_s, sheet: sheet2 }
     # end
   end


   def fix_sheet_for_clientside sheet
      sheet.to_json.gsub('"_id":', '"id":')
   end


end
