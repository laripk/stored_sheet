# copied from http://stackoverflow.com/questions/6581135/how-to-build-deeply-nested-models-in-backbone-js-v0-5
# I renamed RailsModel to NestedModel

root = this
prevBackboneExt = root.BackboneExt
BackboneExt = root.BackboneExt = {}

#= require jquery
#= require underscore
#= require backbone
#
class BackboneExt.NestedModel extends Backbone.Model

   initialize: (attributes) ->
      data = {}

      for k,v of @attributes
         if v.constructor.name == "Object"
            data[k] = new NestedModel(v)

      @set data, {silent: true}

   get: (field)->
      val    = @
      first =   true
      for p in field.split('/')
         if first
            val = super(p)
         else
            # This allows returning *undefined* rather
            # than an exception if the parent of a deeply
            # nested node does not exist.
            val = if val? then val.get(p) else undefined
         first = false
      val

   # Allow heirarchical setting of objects
   #
   # Example
   #
   # model.set_field('root/child', 10)
   #
   # Will create the path if it does not exist
   set_field: (field, value, silent=false)->
      path = field.split('/')

      node = undefined
      val    = @
      for p in field.split('/')
         node = val
         val = node.get(p)
         if not val?
            data = {}
            val = new NestedModel
            data[p] = val
            node.set data

      data = {}
      data[p] = value
      node.set data

      if not silent and /\//.test(field)
         @trigger("change:#{field}", @model, value)
         @trigger("change", @model)

