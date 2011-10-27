class StoredSheet.Models.Column extends Backbone.Model
   # defaults:
   constructor: (attribs, options) ->
      super(attribs, options)
      data = @parse attribs
      @set data, {silent: true}
   parse: (attribs) ->
      data = attribs || {}
      data['editor'] = TextCellEditor
      return data
   toJSON: ->
      data = {}
      for key, val of this
         if key in ['id']
            data[key] = val
      for key, val of @attributes
         if key in ['field', 'name', 'num', 'width']
            data[key] = val
      return data
   
class StoredSheet.Collections.Columns extends Backbone.Collection
   model: StoredSheet.Models.Column
