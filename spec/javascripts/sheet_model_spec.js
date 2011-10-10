(function() {
  describe("jasmine hookup", function() {
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = StoredSheet;
      return expect(ss).toBeTruthy();
    });
    return it("can create a Sheet", function() {
      var sht;
      sht = new StoredSheet.Sheet();
      return expect(sht).toBeTruthy();
    });
  });
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
        return expect(this.sht.get('columns').constructor.name).toEqual('Array');
      });
      it("should have rows of type Rows", function() {
        return expect(this.sht.get('rows').constructor.name).toEqual('Array');
      });
      it("should have first column of type Column", function() {
        return expect(this.sht.get('columns')[0].constructor.name).toEqual('Object');
      });
      it("should have first row of type Row", function() {
        return expect(this.sht.get('rows')[0].constructor.name).toEqual('Object');
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
      it("should clientize second column", function() {
        var col2;
        this.sht.clientize();
        col2 = this.sht.get('columns')[1];
        return expect(col2.editor).toBe(TextCellEditor);
      });
      return it("should serverize second column", function() {
        var col2;
        this.sht.serverize();
        col2 = this.sht.get('columns')[1];
        return expect(col2.editor).toBe(null);
      });
    });
  });
}).call(this);
