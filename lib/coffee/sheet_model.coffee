
### Sheet Model ###

class StoredSheet.Sheet extends Backbone.Model # BackboneExt.NestedModel
   urlRoot: '/shts'
   initialize: (attribs) ->
      data = @parse attribs
      @set data, {silent: true}
   parse: (attribs) ->
      data = {}
      for key,val of attribs
         switch key
            when 'columns'
               data['columns'] = new StoredSheet.Columns(val)
            when 'rows'
               data['rows'] = new StoredSheet.Rows(val)
            else
               data[key] = val
      return data
   # clientize: ->
   #    @get('columns').clientize()
   # serverize: ->
   #    @get('columns').serverize()
   toJSON: ->
      data = {}
      for key, val of @attributes
         if val.toJSON?
            data[key] = val.toJSON()
         else
            data[key] = val
      return data
   

### Row Model ###

class StoredSheet.Row # extends Backbone.Model
   constructor: (attribs) ->
      _.extend this, @parse(attribs)
   parse: (attribs) ->
      return attribs
   toJSON: ->
      data = {}
      for key, val of this
         unless key in ['_callbacks', 'parse', 'toJSON', 'bind', 'unbind', 'trigger']
            data[key] = val
      return data

_.extend(StoredSheet.Row.prototype, Backbone.Events)


class StoredSheet.Rows extends Backbone.Collection
   model: StoredSheet.Row


### Column Model ###

class StoredSheet.Column # extends Backbone.Model
   constructor: (attribs) ->
      _.extend this, @parse(attribs)
   parse: (attribs) ->
      data = attribs || {}
      data['editor'] = TextCellEditor
      return data
   toJSON: ->
      data = {}
      for key, val of this
         unless key in ['editor', '_callbacks', 'parse', 'toJSON', 'bind', 'unbind', 'trigger']
            data[key] = val
      return data

_.extend(StoredSheet.Column.prototype, Backbone.Events)


class StoredSheet.Columns extends Backbone.Collection
   model: StoredSheet.Column
   # clientize: ->
   #    @each (col) -> col.clientize()
   # serverize: ->
   #    @each (col) -> col.serverize()

