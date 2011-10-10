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
    NamedGrid.prototype.render = function() {
      return this;
    };
    return NamedGrid;
  })();
}).call(this);
