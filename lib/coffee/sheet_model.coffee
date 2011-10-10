
### Sheet Model ###

class StoredSheet.Sheet extends NestedModel
   urlRoot: '/shts'
   clientize: ->
      cols = @get 'columns'
      _.each cols, (col) ->
         col.editor = TextCellEditor
   serverize: ->
      cols = @get 'columns'
      _.each cols, (col) ->
         col.editor = null 

## Not using because nesting doesn't want to work with custom objects
# 
# ### Row Model ###
# 
# class StoredSheet.Row extends Backbone.Model
#    
# 
# class StoredSheet.Rows extends Backbone.Collection
#    model: StoredSheet.Row
# 
# 
# ### Column Model ###
# 
# class StoredSheet.Column extends Backbone.Model
#    clientize: ->
#       @set({ "editor": TextCellEditor })
#    serverize: ->
#       @set({ "editor": null })
# 
# class StoredSheet.Columns extends Backbone.Collection
#    model: StoredSheet.Column
#    clientize: ->
#       @each (col) -> col.clientize
#    serverize: ->
#       @each (col) -> col.serverize
# 
