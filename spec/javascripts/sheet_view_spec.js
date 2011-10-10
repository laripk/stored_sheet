(function() {
  describe("Grid jasmine hookup", function() {
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = StoredSheet;
      return expect(ss).toBeTruthy();
    });
    return it("can create a NamedGrid", function() {
      var grd;
      grd = new StoredSheet.NamedGrid();
      return expect(grd).toBeTruthy();
    });
  });
}).call(this);
