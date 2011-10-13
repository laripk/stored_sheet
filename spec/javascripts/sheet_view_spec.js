(function() {
  describe("Grid jasmine hookup", function() {
    beforeEach(function() {
      this.samplesheet = {
        id: 'decaf00004',
        sheet_name: 'Example Sheet',
        columns: [
          {
            id: 'decaf00001',
            name: 'A',
            num: 1,
            field: 'Field1',
            width: 100
          }, {
            id: 'decaf00002',
            name: 'B',
            num: 2,
            field: 'Field2',
            width: 100
          }, {
            id: 'decaf00003',
            name: 'C',
            num: 3,
            field: 'Field3',
            width: 100
          }
        ],
        rows: [
          {
            id: 'decaf00005'
          }, {
            id: 'decaf00006'
          }, {
            id: 'decaf00007'
          }
        ]
      };
      return this.sht = new StoredSheet.Sheet(this.samplesheet);
    });
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = StoredSheet;
      return expect(ss).toBeTruthy();
    });
    return it("can create a NamedGrid", function() {
      var grd;
      document.write("<form id='sheetform'><div id='mygrid'></div></form>");
      grd = new StoredSheet.NamedGrid({
        model: this.sht
      });
      return expect(grd).toBeTruthy();
    });
  });
}).call(this);
