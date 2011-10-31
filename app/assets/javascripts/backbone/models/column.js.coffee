class StoredSheet.Models.Column # extends Backbone.Model
   constructor: (attribs, options) ->
      _.extend this, @parse(attribs)
      # super(attribs, options)
      # data = @parse attribs
      # @set data, {silent: true}
   parse: (attribs) ->
      data = attribs || {}
      data['editor'] = TextCellEditor
      return data
   toJSON: ->
      data = {}
      # for key, val of this
      #    if key in ['id']
      #       data[key] = val
      for key, val of this # @attributes
         if key in ['id', 'field', 'name', 'num', 'width']
            data[key] = val
      return data
   get: (item) ->
      this[item]
      # this method is only here because I got tired of switching my tests' syntax back and forth
_.extend(StoredSheet.Models.Column.prototype, Backbone.Events)

class StoredSheet.Collections.Columns extends Backbone.Collection
   model: StoredSheet.Models.Column
   # getItem =(index) ->
   #    @at index
