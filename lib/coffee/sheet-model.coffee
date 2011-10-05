
class Column extends Backbone.Model
   clientize: ->
      @set({ "editor": TextCellEditor })
   serverize: ->
      @set({ "editor": null })
   
class Columns extends Backbone.Collection
   model: Column
   clientize: ->
      @each (col) -> col.clientize
   serverize: ->
      @each (col) -> col.serverize

class Row extends Backbone.Model
   
   
class Rows extends Backbone.Collection
   model: Row


### Sheet Model ###

class Sheet extends Backbone.Model
   urlRoot: '/shts'
   