
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

class StoredSheet.Sheet extends Backbone.Model
   urlRoot: '/shts'
   defaults:
      columns: new StoredSheet.Columns()
      rows: new StoredSheet.Rows()
