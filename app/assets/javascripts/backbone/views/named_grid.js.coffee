class StoredSheet.Views.NamedGrid extends Backbone.View
   # contains a Grid view
   # make the name, Save button & status area part of the parent view, NamedGrid
   id: 'sheetform'
   
   events:
      'click #savebtn':     'saveSheet'
      'change #sheet_name': 'updateSheetName'
   
   initialize: ->
      @grid = new StoredSheet.Views.Grid({ model: @model, el: @$('mygrid') })
   
   render: ->
      # blah blah blah
      return this # this trick allows for method chaining
   
   updateSheetName: ->
      @model.set {sheet_name: $("#sheet_name").val()}
   
   saveSheet: ->
      @model.save({}, {success: @onSaveSuccess, error: @onSaveFailure})
   
   onSaveSuccess: (model, data, request) ->
      # sheet = data # I'm thinking it already got updated within the save()
      @$(".status").empty().append(request.statusText)

   onSaveFailure: (model, request, options) ->
      if request.status is 200 
         @$(".status").empty().append(request.responseText)
      else
         @$(".status").empty().append(request.statusText + ' ' + request.status + ' - ' + $(request.responseText).filter(':not(style)').text())
         
   
