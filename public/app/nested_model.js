(function() {
  var NestedModel, root;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  root = this;
  NestedModel = (function() {
    __extends(NestedModel, Backbone.Model);
    function NestedModel() {
      NestedModel.__super__.constructor.apply(this, arguments);
    }
    NestedModel.prototype.initialize = function(attributes) {
      var data, k, v, _ref;
      data = {};
      _ref = this.attributes;
      for (k in _ref) {
        v = _ref[k];
        if (v.constructor.name === "Object") {
          data[k] = new NestedModel(v);
        }
      }
      return this.set(data, {
        silent: true
      });
    };
    NestedModel.prototype.get = function(field) {
      var first, p, val, _i, _len, _ref;
      val = this;
      first = true;
      _ref = field.split('/');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        if (first) {
          val = NestedModel.__super__.get.call(this, p);
        } else {
          val = val != null ? val.get(p) : void 0;
        }
        first = false;
      }
      return val;
    };
    NestedModel.prototype.set_field = function(field, value, silent) {
      var data, node, p, path, val, _i, _len, _ref;
      if (silent == null) {
        silent = false;
      }
      path = field.split('/');
      node = void 0;
      val = this;
      _ref = field.split('/');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        node = val;
        val = node.get(p);
        if (!(val != null)) {
          data = {};
          val = new NestedModel;
          data[p] = val;
          node.set(data);
        }
      }
      data = {};
      data[p] = value;
      node.set(data);
      if (!silent && /\//.test(field)) {
        this.trigger("change:" + field, this.model, value);
        return this.trigger("change", this.model);
      }
    };
    return NestedModel;
  })();
  root.NestedModel = NestedModel;
}).call(this);
