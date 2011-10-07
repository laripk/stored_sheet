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
  describe("Row", function() {
    return it("creates a row with initial value", function() {
      var row, val;
      val = {
        id: 'decaf00005'
      };
      row = new StoredSheet.Row(val);
      expect(row).toBeTruthy();
      expect(row.constructor.name).toEqual('Row');
      return expect(row.get('id')).toEqual('decaf00005');
    });
  });
  describe("Rows", function() {
    return it("creates a row list with initial value", function() {
      var row, rows, val;
      val = [
        {
          id: 'decaf00005'
        }, {
          id: 'decaf00006'
        }, {
          id: 'decaf00007'
        }
      ];
      rows = new StoredSheet.Rows(val);
      expect(rows).toBeTruthy();
      expect(rows.constructor.name).toEqual('Rows');
      row = rows.at(0);
      expect(row.constructor.name).toEqual('Row');
      return expect(row.get('id')).toEqual('decaf00005');
    });
  });
  describe("Column", function() {});
  describe("Columns", function() {});
  describe("Sheet", function() {
    beforeEach(function() {
      return this.samplesheet = {
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
    });
    return describe("initialized from server data", function() {
      beforeEach(function() {
        return this.sht = new StoredSheet.Sheet(this.samplesheet);
      });
      it("should be a Sheet", function() {
        return expect(this.sht.constructor.name).toEqual('Sheet');
      });
      it("should have columns of type Columns", function() {
        return expect(this.sht.get('columns').constructor.name).toEqual('Columns');
      });
      it("should have rows of type Rows", function() {
        return expect(this.sht.get('rows').constructor.name).toEqual('Rows');
      });
      it("should have first column of type Column", function() {
        return expect(this.sht.get('columns')[0].constructor.name).toEqual('Column');
      });
      it("should have first row of type Row", function() {
        return expect(this.sht.get('rows')[0].constructor.name).toEqual('Row');
      });
      it("should have the sheet_name", function() {
        return expect(this.sht.get("sheet_name")).toEqual("Example Sheet");
      });
      it("should have three rows", function() {
        return expect(this.sht.get('rows').length).toEqual(3);
      });
      it("should have the id of the third row", function() {
        var row3;
        row3 = this.sht.get('rows')[2];
        return expect(row3.id).toEqual('decaf00007');
      });
      it("should be able to add a value to the third row", function() {
        var row3;
        row3 = this.sht.get('rows')[2];
        expect(row3.Field1 != null).toBeFalsy();
        row3.Field1 = 'froggies';
        return expect(row3.Field1).toEqual('froggies');
      });
      it("should have three columns", function() {
        var cols;
        cols = this.sht.get('columns');
        expect(cols.length).toEqual(3);
        return expect(this.sht.get('columns').length).toEqual(3);
      });
      it("should have a second column named 'B'", function() {
        var col2;
        col2 = this.sht.get('columns')[1];
        return expect(col2.name).toEqual('B');
      });
      return it("should clientize second column", function() {
        var col2;
        col2 = this.sht.get('columns')[1];
        col2.clientize();
        return expect(col2.editor).toBe(TextEditor);
      });
    });
  });
}).call(this);
