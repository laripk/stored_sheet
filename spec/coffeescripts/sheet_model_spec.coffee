
describe "Sheet jasmine hookup", ->

   it "sees the StoredSheet namespace", ->
      ss = StoredSheet
      expect(ss).toBeTruthy()
      # expect(ss).toEqual '' # for taking a peek inside; not what I really expect

   it "can create a Sheet", ->
      sht = new StoredSheet.Sheet()
      expect(sht).toBeTruthy()

   it "can create a Row", ->
      rw = new StoredSheet.Row()
      expect(rw).toBeTruthy()
   
   it "can create a Rows", ->
      rws = new StoredSheet.Rows()
      expect(rws).toBeTruthy()
   
   it "can create a Column", ->
      col = new StoredSheet.Column()
      expect(col).toBeTruthy()
   
   it "can create a Columns", ->
      cols = new StoredSheet.Columns()
      expect(cols).toBeTruthy()
#end describe

describe "Sheet", ->
   beforeEach ->
      @samplesheet = 
         id: 'decaf00004'
         sheet_name: 'Example Sheet'
         columns: [
            id: 'decaf00001'
            name: 'A'
            num: 1
            field: 'Field1'
            width: 100
         ,
            id: 'decaf00002'
            name: 'B'
            num: 2
            field: 'Field2'
            width: 100
         ,
            id: 'decaf00003'
            name: 'C'
            num: 3
            field: 'Field3'
            width: 100
         ]
         rows: [
            id: 'decaf00005'
         ,
            id: 'decaf00006'
         ,
            id: 'decaf00007'
         ]
      @sht = new StoredSheet.Sheet @samplesheet

   
   describe "initialized from server data", ->
      
      it "should be a Sheet", ->
         expect(@sht.constructor.name).toEqual 'Sheet'

      it "should have columns of type Columns", ->
         expect(@sht.get('columns').constructor.name).toEqual 'Columns'
      
      it "should have rows of type Rows", ->
         expect(@sht.get('rows').constructor.name).toEqual 'Rows'
      
      it "should have first column of type Column", ->
         expect(@sht.get('columns').at(0).constructor.name).toEqual 'Column'
      
      it "should have first row of type Row", ->
         expect(@sht.get('rows').at(0).constructor.name).toEqual 'Row'
      
      it "should have the sheet_name", ->
         expect(@sht.get "sheet_name").toEqual "Example Sheet"
      
      it "should have three rows", ->
         expect(@sht.get('rows').length).toEqual 3
      
      it "should have the id of the third row", ->
         row3 = @sht.get('rows').at(2)
         expect(row3.id).toEqual 'decaf00007'
      
      it "should have three columns", ->
         cols = @sht.get 'columns'
         expect(cols.length).toEqual 3
         expect(@sht.get('columns').length).toEqual 3 # checking alternate syntax
      
      it "should have a second column named 'B'", ->
         col2 = @sht.get('columns').at(1)
         expect(col2.get("name")).toEqual 'B'

      it "should clientize second column", ->
         col2 = @sht.get('columns').at(1)
         col2.clientize()
         expect(col2.get("editor")).toBe TextCellEditor

      it "should serverize second column", ->
         col2 = @sht.get('columns').at(1)
         col2.serverize()
         expect(col2.has('editor')).toBeFalsy()

      it "should clientize the sheet", ->
         @sht.clientize()
         expect(@sht.get('columns').at(1).get("editor")).toBe TextCellEditor

      it "should serverize the sheet", ->
         @sht.serverize()
         expect(@sht.get('columns').at(1).has('editor')).toBeFalsy()

      it "should JSONify properly", ->
         json = { 
            id : 'decaf00004', 
            sheet_name : 'Example Sheet', 
            columns : [ 
               { id : 'decaf00001', name : 'A', num : 1, field : 'Field1', width : 100 }, 
               { id : 'decaf00002', name : 'B', num : 2, field : 'Field2', width : 100 }, 
               { id : 'decaf00003', name : 'C', num : 3, field : 'Field3', width : 100 } 
            ], 
            rows : [ 
               { id : 'decaf00005' }, 
               { id : 'decaf00006' }, 
               { id : 'decaf00007' } 
            ] 
         } 
         expect(@sht.toJSON()).toEqual json

   describe "modification", ->
      
      it "should be able to add a value to the third row", ->
         row3 = @sht.get('rows').at(2)
         expect(row3.has('Field1')).toBeFalsy()
         row3.set({'Field1': 'froggies'})
         expect(row3.get('Field1')).toEqual 'froggies'
         
      it "should trigger a change event when adding a cell value", ->
         what_changed = (obj) ->
            expect(obj.constructor.name).toEqual 'Row'
            expect(obj.changedAttributes()).toEqual {Field1: 'froggies'}
            # return [obj.constructor.name, obj.changedAttributes()]
         @sht.bind 'change', what_changed, @sht
         row3 = @sht.get('rows').at(2)
         row3.bind 'change', what_changed, row3
         expect(row3.has('Field1')).toBeFalsy()
         row3.set({'Field1': 'froggies'})
         # expect(row3.changedAttributes()).toEqual ['Field1']
   

   
   describe "saving & fetching", ->
      beforeEach ->
         jasmine.Ajax.useMock()
         @sht.get('rows').at(0).set({'Field1': 'kitties'})
         @sht.get('rows').at(1).set({'Field2': 'birdies'})
         @sht.get('rows').at(2).set({'Field3': 'froggies'})
         @jsonmod = { 
            id : 'decaf00004', 
            sheet_name : 'Example Sheet', 
            columns : [ 
               { id : 'decaf00001', name : 'A', num : 1, field : 'Field1', width : 100 }, 
               { id : 'decaf00002', name : 'B', num : 2, field : 'Field2', width : 100 }, 
               { id : 'decaf00003', name : 'C', num : 3, field : 'Field3', width : 100 } 
            ], 
            rows : [ 
               { id : 'decaf00005', Field1 : 'kitties' }, 
               { id : 'decaf00006', Field2 : 'birdies' }, 
               { id : 'decaf00007', Field3 : 'froggies' } 
            ] 
         }
         @jsonmodtxt = '{"id":"decaf00004","sheet_name":"Example Sheet","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}'
         @fakeResponse =
            status: 200
            responseText: @jsonmodtxt
      
      it "should JSONify properly", ->
         expect(@sht.toJSON()).toEqual @jsonmod
      
      it "should save", ->
         onSuccess = jasmine.createSpy('onSuccess')
         onFailure = jasmine.createSpy('onFailure')
         syncSpy = spyOn(Backbone, 'sync').andCallThrough()
         
         @sht.save({}, {success: onSuccess, error: onFailure})
         # @sht.save(@sht.toJSON(), {success: onSuccess, error: onFailure})
         
         req = mostRecentAjaxRequest()
         req.response @fakeResponse
         
         expect(onSuccess).toHaveBeenCalled()
         expect(onSuccess.mostRecentCall.args[2].statusText).toEqual 'success'

         expect(req.method).toEqual 'PUT'
         expect(req.url).toEqual '/shts/decaf00004'
         expect(req.params).toEqual @jsonmodtxt

         expect(syncSpy).toHaveBeenCalled()
         expect(syncSpy.mostRecentCall.args[0]).toEqual 'update'
         

describe "Row", ->
   
   it "creates a row with initial value", ->
      val =
         id: 'decaf00005'
      row = new StoredSheet.Row(val)
      expect(row?).toBeTruthy()
      expect(row.constructor.name).toEqual 'Row'
      expect(row.get 'id').toEqual 'decaf00005'
   

describe "Rows", ->

   it "creates a row list with initial value", ->
      val = [
         id: 'decaf00005'
      ,
         id: 'decaf00006'
      ,
         id: 'decaf00007'
      ]
      rows = new StoredSheet.Rows(val)
      expect(rows?).toBeTruthy()
      expect(rows.constructor.name).toEqual 'Rows'
      row = rows.at(0)
      expect(row.constructor.name).toEqual 'Row'      
      expect(row.get 'id').toEqual 'decaf00005'
   

describe "Column", ->
   
   it "creates a column with initial value", ->
      val =
         id: 'decaf00001'
         name: 'A'
         num: 1
         field: 'Field1'
         width: 100
      col = new StoredSheet.Column(val)
      expect(col?).toBeTruthy()
      expect(col.constructor.name).toEqual 'Column'
      expect(col.get 'id').toEqual 'decaf00001'
      expect(col.get 'name').toEqual 'A'
      expect(col.get 'id').toEqual 'decaf00001'
      expect(col.get 'field').toEqual 'Field1'
      expect(col.get 'width').toEqual 100

describe "Columns", ->
   
   it "creates a column list with initial value", ->
      val = [
         id: 'decaf00001'
         name: 'A'
         num: 1
         field: 'Field1'
         width: 100
      ,
         id: 'decaf00002'
         name: 'B'
         num: 2
         field: 'Field2'
         width: 100
      ,
         id: 'decaf00003'
         name: 'C'
         num: 3
         field: 'Field3'
         width: 100
      ]
      cols = new StoredSheet.Columns(val)
      expect(cols?).toBeTruthy()
      expect(cols.constructor.name).toEqual 'Columns'
      col = cols.at(0)
      expect(col.constructor.name).toEqual 'Column'
      expect(col.get 'id').toEqual 'decaf00001'
      expect(col.get 'name').toEqual 'A'
      expect(col.get 'id').toEqual 'decaf00001'
      expect(col.get 'field').toEqual 'Field1'
      expect(col.get 'width').toEqual 100
      


