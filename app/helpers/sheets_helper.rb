module SheetsHelper

   def fix_sheet_for_clientside sheet
      sheet.to_json.gsub('"_id":', '"id":')
   end

end
