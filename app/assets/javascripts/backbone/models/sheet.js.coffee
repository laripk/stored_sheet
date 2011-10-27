class StoredSheet.Models.Sheet extends Backbone.Model
   url: '/sheets'
   paramRoot: 'sheet'

   defaults:
      sheet_name: null
   
   initialize: (attribs) ->
      data = @parse attribs
      @set data, {silent: true}
   parse: (attribs) ->
      data = {}
      for key,val of attribs
         switch key
            when 'columns'
               data['columns'] = new StoredSheet.Collections.Columns(val)
            when 'rows'
               data['rows'] = new StoredSheet.Collections.Rows(val)
            else
               data[key] = val
      return data
   toJSON: ->
      data = {}
      for key, val of @attributes
         if val.toJSON?
            data[key] = val.toJSON()
         else
            data[key] = val
      return data
   
# class StoredSheet.Collections.Sheets extends Backbone.Collection
#    model: StoredSheet.Models.Sheet
#    url: '/sheets'
