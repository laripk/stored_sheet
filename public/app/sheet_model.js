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
    __extends(Sheet, Backbone.Model);
    function Sheet() {
      Sheet.__super__.constructor.apply(this, arguments);
    }
    Sheet.prototype.urlRoot = '/shts';
    Sheet.prototype.initialize = function(attribs) {
      var data;
      data = this.parse(attribs);
      return this.set(data, {
        silent: true
      });
    };
    Sheet.prototype.parse = function(attribs) {
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
      return data;
    };
    Sheet.prototype.toJSON = function() {
      var data, key, val, _ref;
      data = {};
      _ref = this.attributes;
      for (key in _ref) {
        val = _ref[key];
        if (val.toJSON != null) {
          data[key] = val.toJSON();
        } else {
          data[key] = val;
        }
      }
      return data;
    };
    return Sheet;
  })();
  /* Row Model */
  StoredSheet.Row = (function() {
    function Row(attribs) {
      _.extend(this, this.parse(attribs));
    }
    Row.prototype.parse = function(attribs) {
      return attribs;
    };
    Row.prototype.toJSON = function() {
      var data, key, val;
      data = {};
      for (key in this) {
        val = this[key];
        if (key !== '_callbacks' && key !== 'parse' && key !== 'toJSON' && key !== 'bind' && key !== 'unbind' && key !== 'trigger') {
          data[key] = val;
        }
      }
      return data;
    };
    return Row;
  })();
  _.extend(StoredSheet.Row.prototype, Backbone.Events);
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
    function Column(attribs) {
      _.extend(this, this.parse(attribs));
    }
    Column.prototype.parse = function(attribs) {
      var data;
      data = attribs || {};
      data['editor'] = TextCellEditor;
      return data;
    };
    Column.prototype.toJSON = function() {
      var data, key, val;
      data = {};
      for (key in this) {
        val = this[key];
        if (key !== 'editor' && key !== '_callbacks' && key !== 'parse' && key !== 'toJSON' && key !== 'bind' && key !== 'unbind' && key !== 'trigger') {
          data[key] = val;
        }
      }
      return data;
    };
    return Column;
  })();
  _.extend(StoredSheet.Column.prototype, Backbone.Events);
  StoredSheet.Columns = (function() {
    __extends(Columns, Backbone.Collection);
    function Columns() {
      Columns.__super__.constructor.apply(this, arguments);
    }
    Columns.prototype.model = StoredSheet.Column;
    return Columns;
  })();
}).call(this);
