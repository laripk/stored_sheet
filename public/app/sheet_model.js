(function() {
  /* Row Model */
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
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
  /* Sheet Model */
  StoredSheet.Sheet = (function() {
    __extends(Sheet, NestedModel);
    function Sheet() {
      Sheet.__super__.constructor.apply(this, arguments);
    }
    Sheet.prototype.urlRoot = '/shts';
    Sheet.prototype.initialize = function(attributes) {
      var data, k, v, _ref;
      data = {};
      _ref = this.attributes;
      for (k in _ref) {
        v = _ref[k];
        if (v.constructor.name === "Object") {
          switch (k) {
            case 'columns':
              data[k] = new StoredSheet.Columns(v);
              break;
            case 'rows':
              data[k] = new StoredSheet.Rows(v);
              break;
            default:
              data[k] = new NestedModel(v);
          }
        }
      }
      return this.set(data, {
        silent: true
      });
    };
    return Sheet;
  })();
}).call(this);
