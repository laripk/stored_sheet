window.StoredSheet = {}

### Sheet Model ###

class StoredSheet.Sheet extends Backbone.Model
   urlRoot: '/shts'
   constructor: ->
      @set({columns: new Columns})
      @set({rows: new Rows})
      super

### Column Model ###

class StoredSheet.Column extends Backbone.Model
   clientize: ->
      @set({ "editor": TextCellEditor })
   serverize: ->
      @set({ "editor": null })

class StoredSheet.Columns extends Backbone.Collection
   model: Column
   clientize: ->
      @each (col) -> col.clientize
   serverize: ->
      @each (col) -> col.serverize


### Row Model ###

class StoredSheet.Row extends Backbone.Model


class StoredSheet.Rows extends Backbone.Collection
   model: Row

