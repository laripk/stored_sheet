(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  StoredSheet.NamedGrid = (function() {
    __extends(NamedGrid, Backbone.View);
    function NamedGrid() {
      NamedGrid.__super__.constructor.apply(this, arguments);
    }
    NamedGrid.prototype.id = 'sheetform';
    NamedGrid.prototype.events = {
      'click #savebtn': 'saveSheet',
      'change #sheet_name': 'updateSheetName'
    };
    NamedGrid.prototype.initialize = function() {
      return this.grid = new StoredSheet.Grid({
        model: this.model,
        el: this.$('mygrid')
      });
    };
    NamedGrid.prototype.render = function() {
      return this;
    };
    NamedGrid.prototype.updateSheetName = function() {
      return this.model.set({
        sheet_name: $("#sheet_name").val()
      });
    };
    NamedGrid.prototype.saveSheet = function() {
      this.model.serverize();
      return this.model.save({}, {
        success: onSaveSuccess,
        error: onSaveFailure
      });
    };
    NamedGrid.prototype.onSaveSuccess = function(model, data, request) {
      return this.$(".status").empty().append(request.statusText);
    };
    NamedGrid.prototype.onSaveFailure = function(model, request, options) {
      return this.$(".status").empty().append(request.statusText + ' - ' + request.error());
    };
    return NamedGrid;
  })();
  StoredSheet.Grid = (function() {
    __extends(Grid, Backbone.View);
    function Grid() {
      Grid.__super__.constructor.apply(this, arguments);
    }
    Grid.prototype.className = 'gridcontainer';
    Grid.prototype.id = 'mygrid';
    Grid.prototype.events = {};
    Grid.prototype.initialize = function() {
      return this.grid = new Slick.Grid("#mygrid", this.model.get("rows").models, this.model.get("columns").models, this.gridOptions);
    };
    Grid.prototype.render = function() {
      return this;
    };
    Grid.prototype.gridOptions = {
      editable: true,
      autoEdit: true,
      asyncEditorLoading: false,
      enableCellNavigation: true,
      enableColumnReorder: false
    };
    return Grid;
  })();
}).call(this);
