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
    Sheet.prototype.clientize = function() {
      var cols;
      cols = this.get('columns');
      return _.each(cols, function(col) {
        return col.editor = TextCellEditor;
      });
    };
    Sheet.prototype.serverize = function() {
      var cols;
      cols = this.get('columns');
      return _.each(cols, function(col) {
        return col.editor = null;
      });
    };
    return Sheet;
  })();
}).call(this);
