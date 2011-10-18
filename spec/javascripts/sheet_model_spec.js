(function() {
  describe("Sheet jasmine hookup", function() {
    it("sees the StoredSheet namespace", function() {
      var ss;
      ss = StoredSheet;
      return expect(ss).toBeTruthy();
    });
    it("can create a Sheet", function() {
      var sht;
      sht = new StoredSheet.Sheet();
      return expect(sht).toBeTruthy();
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
    return it("can create a Columns", function() {
      var cols;
      cols = new StoredSheet.Columns();
      return expect(cols).toBeTruthy();
    });
  });
  describe("Sheet", function() {
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
    describe("initialized from server data", function() {
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
        return expect(this.sht.get('columns').at(0).constructor.name).toEqual('Column');
      });
      it("should have first row of type Row", function() {
        return expect(this.sht.get('rows').at(0).constructor.name).toEqual('Row');
      });
      it("should have the sheet_name", function() {
        return expect(this.sht.get("sheet_name")).toEqual("Example Sheet");
      });
      it("should have three rows", function() {
        return expect(this.sht.get('rows').length).toEqual(3);
      });
      it("should have the id of the third row", function() {
        var row3;
        row3 = this.sht.get('rows').at(2);
        return expect(row3.id).toEqual('decaf00007');
      });
      it("should have three columns", function() {
        var cols;
        cols = this.sht.get('columns');
        expect(cols.length).toEqual(3);
        return expect(this.sht.get('columns').length).toEqual(3);
      });
      it("should have a second column named 'B'", function() {
        var col2;
        col2 = this.sht.get('columns').at(1);
        return expect(col2["name"]).toEqual('B');
      });
      it("should clientize second column", function() {
        var col2;
        col2 = this.sht.get('columns').at(1);
        return expect(col2["editor"]).toBe(TextCellEditor);
      });
      it("should serverize second column", function() {
        var col2;
        col2 = this.sht.get('columns').at(1);
        return expect(col2.toJSON()['editor'] != null).toBeFalsy();
      });
      it("should clientize the sheet", function() {
        return expect(this.sht.get('columns').at(1)["editor"]).toBe(TextCellEditor);
      });
      it("should serverize the sheet", function() {
        return expect(this.sht.toJSON()['columns'][1]['editor'] != null).toBeFalsy();
      });
      return it("should JSONify properly", function() {
        var json;
        json = {
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
        return expect(this.sht.toJSON()).toEqual(json);
      });
    });
    describe("modification", function() {
      it("should be able to add a value to the third row", function() {
        var row3;
        row3 = this.sht.get('rows').at(2);
        expect(row3['Field1'] != null).toBeFalsy();
        row3['Field1'] = 'froggies';
        return expect(row3['Field1']).toEqual('froggies');
      });
      return it("should trigger a change event when adding a cell value", function() {
        var row3, what_changed;
        what_changed = function(obj) {
          expect(obj.constructor.name).toEqual('Row');
          return expect(obj.changedAttributes()).toEqual({
            Field1: 'froggies'
          });
        };
        this.sht.bind('change', what_changed, this.sht);
        row3 = this.sht.get('rows').at(2);
        row3.bind('change', what_changed, row3);
        expect(row3['Field1'] != null).toBeFalsy();
        return row3['Field1'] = 'froggies';
      });
    });
    describe("saving & fetching", function() {
      beforeEach(function() {
        jasmine.Ajax.useMock();
        this.sht.get('rows').at(0)['Field1'] = 'kitties';
        this.sht.get('rows').at(1)['Field2'] = 'birdies';
        this.sht.get('rows').at(2)['Field3'] = 'froggies';
        this.jsonmod = {
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
              id: 'decaf00005',
              Field1: 'kitties'
            }, {
              id: 'decaf00006',
              Field2: 'birdies'
            }, {
              id: 'decaf00007',
              Field3: 'froggies'
            }
          ]
        };
        this.jsonmodparsed = {
          id: 'decaf00004',
          sheet_name: 'Example Sheet',
          columns: [
            {
              id: 'decaf00001',
              name: 'A',
              num: 1,
              field: 'Field1',
              width: 100,
              editor: TextCellEditor
            }, {
              id: 'decaf00002',
              name: 'B',
              num: 2,
              field: 'Field2',
              width: 100,
              editor: TextCellEditor
            }, {
              id: 'decaf00003',
              name: 'C',
              num: 3,
              field: 'Field3',
              width: 100,
              editor: TextCellEditor
            }
          ],
          rows: [
            {
              id: 'decaf00005',
              Field1: 'kitties'
            }, {
              id: 'decaf00006',
              Field2: 'birdies'
            }, {
              id: 'decaf00007',
              Field3: 'froggies'
            }
          ]
        };
        this.jsonmodtxt = '{"id":"decaf00004","sheet_name":"Example Sheet","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}';
        this.fakeGoodResponse = {
          status: 200,
          responseText: this.jsonmodtxt
        };
        return this.fakeBadResponse = {
          status: 404,
          responseText: this.jsonmodtxt
        };
      });
      it("should JSONify properly", function() {
        return expect(this.sht.toJSON()).toEqual(this.jsonmod);
      });
      it("should save successfully", function() {
        var onFailure, onSuccess, req, sync2Spy, syncSpy;
        onSuccess = jasmine.createSpy('onSuccess');
        onFailure = jasmine.createSpy('onFailure');
        syncSpy = spyOn(Backbone, 'sync').andCallThrough();
        sync2Spy = spyOn(StoredSheet.Sheet, 'sync').andCallThrough();
        this.sht.save({}, {
          success: onSuccess,
          error: onFailure
        });
        req = mostRecentAjaxRequest();
        req.response(this.fakeGoodResponse);
        expect(onSuccess).toHaveBeenCalled();
        expect(onSuccess.mostRecentCall.args[2].statusText).toEqual('success');
        expect(req.method).toEqual('POST');
        expect(req.url).toEqual('/shts/decaf00004');
        expect(req.params).toEqual(this.jsonmodtxt);
        expect(sync2Spy).toHaveBeenCalled();
        expect(sync2Spy.mostRecentCall.args[0]).toEqual('update');
        expect(syncSpy).toHaveBeenCalled();
        return expect(syncSpy.mostRecentCall.args[0]).toEqual('update');
      });
      it("should fail saving gracefully", function() {
        var onFailure, onSuccess, req, sync2Spy, syncSpy;
        onSuccess = jasmine.createSpy('onSuccess');
        onFailure = jasmine.createSpy('onFailure');
        syncSpy = spyOn(Backbone, 'sync').andCallThrough();
        sync2Spy = spyOn(StoredSheet.Sheet, 'sync').andCallThrough();
        this.sht.save({}, {
          success: onSuccess,
          error: onFailure
        });
        req = mostRecentAjaxRequest();
        req.response(this.fakeBadResponse);
        expect(onFailure).toHaveBeenCalled();
        expect(onFailure.mostRecentCall.args[1].statusText).toEqual('error');
        expect(req.method).toEqual('POST');
        expect(req.url).toEqual('/shts/decaf00004');
        expect(req.params).toEqual(this.jsonmodtxt);
        expect(sync2Spy).toHaveBeenCalled();
        expect(sync2Spy.mostRecentCall.args[0]).toEqual('update');
        expect(syncSpy).toHaveBeenCalled();
        return expect(syncSpy.mostRecentCall.args[0]).toEqual('update');
      });
      return it("should fetch", function() {
        var onFailure, onSuccess, req, sht2;
        onSuccess = jasmine.createSpy('onSuccess');
        onFailure = jasmine.createSpy('onFailure');
        sht2 = new StoredSheet.Sheet(this.samplesheet);
        sht2.fetch({
          success: onSuccess,
          error: onFailure
        });
        req = mostRecentAjaxRequest();
        req.response(this.fakeGoodResponse);
        expect(onSuccess).toHaveBeenCalled();
        expect(onSuccess.mostRecentCall.args.length).toEqual(2);
        expect(onSuccess.mostRecentCall.args[1]).toEqual(this.jsonmodparsed);
        expect(req.method).toEqual('GET');
        expect(req.url).toEqual('/shts/decaf00004');
        expect(req.params).toEqual(null);
        expect(sht2.get('rows').at(0)['Field1']).toEqual('kitties');
        expect(sht2.get('rows').at(1)['Field2']).toEqual('birdies');
        return expect(sht2.get('rows').at(2)['Field3']).toEqual('froggies');
      });
    });
    return describe("accessability for SlickGrid", function() {
      return it("works with 'columns[i]'", function() {
        var cols_param;
        cols_param = this.sht.get('columns').models;
        expect(cols_param[0].id).toEqual('decaf00001');
        expect(cols_param[0].name).toEqual('A');
        expect(cols_param[0].width).toEqual(100);
        return expect(cols_param[0].field).toEqual('Field1');
      });
    });
  });
  describe("Row", function() {
    return it("creates a row with initial value", function() {
      var row, val;
      val = {
        id: 'decaf00005'
      };
      row = new StoredSheet.Row(val);
      expect(row != null).toBeTruthy();
      expect(row.constructor.name).toEqual('Row');
      return expect(row.id).toEqual('decaf00005');
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
      expect(rows != null).toBeTruthy();
      expect(rows.constructor.name).toEqual('Rows');
      row = rows.at(0);
      expect(row.constructor.name).toEqual('Row');
      return expect(row.id).toEqual('decaf00005');
    });
  });
  describe("Column", function() {
    return it("creates a column with initial value", function() {
      var col, val;
      val = {
        id: 'decaf00001',
        name: 'A',
        num: 1,
        field: 'Field1',
        width: 100
      };
      col = new StoredSheet.Column(val);
      expect(col != null).toBeTruthy();
      expect(col.constructor.name).toEqual('Column');
      expect(col.id).toEqual('decaf00001');
      expect(col.name).toEqual('A');
      expect(col.id).toEqual('decaf00001');
      expect(col.field).toEqual('Field1');
      return expect(col.width).toEqual(100);
    });
  });
  describe("Columns", function() {
    return it("creates a column list with initial value", function() {
      var col, cols, val;
      val = [
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
      ];
      cols = new StoredSheet.Columns(val);
      expect(cols != null).toBeTruthy();
      expect(cols.constructor.name).toEqual('Columns');
      col = cols.at(0);
      expect(col.constructor.name).toEqual('Column');
      expect(col.id).toEqual('decaf00001');
      expect(col.name).toEqual('A');
      expect(col.id).toEqual('decaf00001');
      expect(col.field).toEqual('Field1');
      return expect(col.width).toEqual(100);
    });
  });
}).call(this);
