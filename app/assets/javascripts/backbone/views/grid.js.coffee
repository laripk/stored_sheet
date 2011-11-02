class StoredSheet.Views.Grid extends Backbone.View
   className: 'gridcontainer'
   id: 'mygrid'
   
   events: {}
   
   initialize: ->
      @grid = new Slick.Grid("#mygrid", [], @model.get("columns").models, @gridOptions)
      @model.get("rows").setGrid @grid

   render: ->
      # blah blah blah
      return this # this trick allows for method chaining
   
   gridOptions: 
      editable: true,
      autoEdit: true,
      asyncEditorLoading: false,
      enableCellNavigation: true,
      enableColumnReorder: false
   


