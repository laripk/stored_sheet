class SheetsController < ApplicationController
   include SheetsHelper

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
      @title = 'View Sheet'
      @sheet = Sheet.find(params[:id])
      # @sheet = fix_sheet_for_clientside sheet
      # @sheet_name = sheet.sheet_name
   end

   def update
      sheet = Sheet.find(params[:id])
   # puts params
      # request.body.rewind
      # passedin = params.inspect + "<br/>" + request.request_method + "<br/>" + request.body.read
      sheet.update_attributes!(params[:sheet]) # JSON.parse()
      sheet2 = Sheet.find(params[:id])
      # @stuff = request.xhr?
      respond_to do |format|
         format.html do
            # update.html.haml
            @title = 'Debug Sheet'
            # @stuff = passedin.to_s
            @sheet = sheet2 
         end
         format.json do 
            render :json => (fix_sheet_for_clientside sheet2)
         end
      end
   end



end
