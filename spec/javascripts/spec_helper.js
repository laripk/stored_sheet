(function() {
  beforeEach(function() {
    return this.addMatchers({
      toBeEmpty: function() {
        return this.actual.length === 0;
      },
      toInclude: function(value) {
        return _.include(this.actual, value);
      }
    });
  });
}).call(this);
