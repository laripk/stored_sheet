class Row
   include Mongoid::Document
   embedded_in :sheet
   
end
