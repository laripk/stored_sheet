class StoredSheet.Views.Grid extends Backbone.View
   className: 'gridcontainer'
   id: 'mygrid'
   
   events: {}
   
   initialize: ->
      @grid = new Slick.Grid("#mygrid", @model.get("rows"), @model.get("columns").models, @gridOptions)

   render: ->
      # blah blah blah
      return this # this trick allows for method chaining
   
   gridOptions: 
      editable: true,
      autoEdit: true,
      asyncEditorLoading: false,
      enableCellNavigation: true,
      enableColumnReorder: false
   


