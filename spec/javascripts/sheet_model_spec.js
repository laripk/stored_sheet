(function() {
  describe("jasmine hookup", function() {
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = window.StoredSheet;
      return expect(ss).toBeTruthy();
    });
    it("sees something in the StoredSheet namespace", function() {
      var ss;
      ss = window.StoredSheet;
      return expect(ss).toEqual('');
    });
    it("can create a Sheet", function() {
      var sht;
      sht = new window.StoredSheet.Sheet();
      return expect(sht).toBeTruthy();
    });
    return it("can create a Row", function() {
      var rw;
      rw = new window.StoredSheet.Row();
      return expect(rw).toBeTruthy();
    });
  });
  describe("Column", function() {});
  describe("Columns", function() {});
  describe("Row", function() {});
  describe("Rows", function() {});
  describe("Sheet", function() {
    var samplesheet;
    samplesheet = {
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
    return describe("initialized from server data", function() {
      beforeEach(function() {
        var sht;
        return sht = new window.StoredSheet.Sheet(samplesheet);
      });
      it("should have the sheet_name", function() {
        return expect(sht.get("sheet_name")).toEqual("Example Sheet");
      });
      return it("should have three columns", function() {
        return expect(sht.columns.length).toEqual(3);
      });
    });
  });
}).call(this);
