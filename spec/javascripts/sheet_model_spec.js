(function() {
  describe("jasmine hookup", function() {
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = StoredSheet;
      return expect(ss).toBeTruthy();
    });
    it("can create a Row", function() {
      var rw;
      rw = new StoredSheet.Row();
      return expect(rw).toBeTruthy();
    });
    it("can create a Rows", function() {
      var rws;
      rws = new StoredSheet.Rows();
      return expect(rws).toBeTruthy();
    });
    it("can create a Column", function() {
      var col;
      col = new StoredSheet.Column();
      return expect(col).toBeTruthy();
    });
    it("can create a Columns", function() {
      var cols;
      cols = new StoredSheet.Columns();
      return expect(cols).toBeTruthy();
    });
    return it("can create a Sheet", function() {
      var sht;
      sht = new StoredSheet.Sheet();
      return expect(sht).toBeTruthy();
    });
  });
  describe("Row", function() {});
  describe("Rows", function() {});
  describe("Column", function() {});
  describe("Columns", function() {});
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
    return describe("initialized from server data", function() {});
  });
}).call(this);
