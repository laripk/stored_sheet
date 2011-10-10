
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


### Sheet Model ###

class StoredSheet.Sheet extends NestedModel
   urlRoot: '/shts'
   # constructor: (attribs) ->
   #    super attribs
   #    this.columns = Backbone.Collection.nest(this, 'columns', new StoredSheet.Columns(attribs['columns']))
   #    this.rows = Backbone.Collection.nest(this, 'rows', new StoredSheet.Rows(attribs['rows']))
      # data = {}
      # for k,v of @attributes
      #    if v.constructor.name == "Object"
      #       switch k 
      #          when'columns'
      #             data[k] = new StoredSheet.Columns(v)
      #          when 'rows'
      #             data[k] = new StoredSheet.Rows(v)
      #          else
      #             data[k] = new NestedModel(v)               
      # @set data, {silent: true}
   # toJSON: ->
   #    json = super(this)
   #    json.columns = @columns.toJSON()
   #    json.rows = @rows.toJSON()


