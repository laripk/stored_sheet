class StoredSheet.Models.Sheet extends Backbone.Model
   paramRoot: 'sheet'

   defaults:
      sheet_name: null
   
class StoredSheet.Collections.Sheets extends Backbone.Collection
   model: StoredSheet.Models.Sheet
   url: '/sheets'
