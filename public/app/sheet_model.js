(function() {
  /* Sheet Model */
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  StoredSheet.Sheet = (function() {
    __extends(Sheet, BackboneExt.NestedModel);
    function Sheet() {
      Sheet.__super__.constructor.apply(this, arguments);
    }
    Sheet.prototype.urlRoot = '/shts';
    Sheet.prototype.initialize = function(attribs) {
      var data, key, val;
      data = {};
      for (key in attribs) {
        val = attribs[key];
        switch (key) {
          case 'columns':
            data['columns'] = new StoredSheet.Columns(val);
            break;
          case 'rows':
            data['rows'] = new StoredSheet.Rows(val);
            break;
          default:
            data[key] = val;
        }
      }
      return this.set(data, {
        silent: true
      });
    };
    return Sheet;
  })();
  /* Row Model */
  StoredSheet.Row = (function() {
    __extends(Row, Backbone.Model);
    function Row() {
      Row.__super__.constructor.apply(this, arguments);
    }
    return Row;
  })();
  StoredSheet.Rows = (function() {
    __extends(Rows, Backbone.Collection);
    function Rows() {
      Rows.__super__.constructor.apply(this, arguments);
    }
    Rows.prototype.model = StoredSheet.Row;
    return Rows;
  })();
  /* Column Model */
  StoredSheet.Column = (function() {
    __extends(Column, Backbone.Model);
    function Column() {
      Column.__super__.constructor.apply(this, arguments);
    }
    Column.prototype.clientize = function() {
      return this.set({
        "editor": TextCellEditor
      });
    };
    Column.prototype.serverize = function() {
      return this.set({
        "editor": null
      });
    };
    return Column;
  })();
  StoredSheet.Columns = (function() {
    __extends(Columns, Backbone.Collection);
    function Columns() {
      Columns.__super__.constructor.apply(this, arguments);
    }
    Columns.prototype.model = StoredSheet.Column;
    Columns.prototype.clientize = function() {
      return this.each(function(col) {
        return col.clientize;
      });
    };
    Columns.prototype.serverize = function() {
      return this.each(function(col) {
        return col.serverize;
      });
    };
    return Columns;
  })();
}).call(this);
