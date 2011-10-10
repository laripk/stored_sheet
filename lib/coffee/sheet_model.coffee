
### Sheet Model ###

class StoredSheet.Sheet extends Backbone.Model # BackboneExt.NestedModel
   urlRoot: '/shts'
   initialize: (attribs) ->
      data = {}
      for key,val of attribs
         switch key
            when 'columns'
               data['columns'] = new StoredSheet.Columns(val)
            when 'rows'
               data['rows'] = new StoredSheet.Rows(val)
            else
               data[key] = val
      @set data, {silent: true}
   # parse: (attribs) ->
   #    data = {}
   #    for key,val of attribs
   #       switch key
   #          when 'columns'
   #             data['columns'] = new StoredSheet.Columns(val)
   #          when 'rows'
   #             data['rows'] = new StoredSheet.Rows(val)
   #          else
   #             data[key] = val
   #    return data
   # clientize: ->
   #    cols = @get 'columns'
   #    _.each cols, (col) ->
   #       col.editor = TextCellEditor
   # serverize: ->
   #    cols = @get 'columns'
   #    _.each cols, (col) ->
   #       col.editor = null 


### Row Model ###

class StoredSheet.Row extends Backbone.Model
   

class StoredSheet.Rows extends Backbone.Collection
   model: StoredSheet.Row


### Column Model ###

class StoredSheet.Column extends Backbone.Model
   clientize: ->
      @set({ "editor": TextCellEditor })
   serverize: ->
      @set({ "editor": null })

class StoredSheet.Columns extends Backbone.Collection
   model: StoredSheet.Column
   clientize: ->
      @each (col) -> col.clientize
   serverize: ->
      @each (col) -> col.serverize

