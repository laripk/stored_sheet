class StoredSheet.Models.Sheet extends Backbone.Model
   urlRoot: '/sheets'
   paramRoot: 'sheet' # this adds {"sheet":<sheet_json>} around the sheet's json

   defaults:
      sheet_name: null
   
   constructor: (attribs, options) ->
      super(attribs, options)
      data = @parse attribs
      @set data, {silent: true}
   parse: (attribs) ->
      data = {}
      for key,val of attribs
         switch key
            when 'columns'
               if @columns
                  data['columns'] = @columns.parse(val)
               else
                  data['columns'] = new StoredSheet.Collections.Columns(val)
            when 'rows'
               if @rows
                  data['rows'] = @rows.parse(val)
               else
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
