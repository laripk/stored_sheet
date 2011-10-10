
describe "jasmine hookup", ->

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

   
   describe "initialized from server data", ->
      beforeEach ->
         @sht = new StoredSheet.Sheet @samplesheet
      
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
      
      it "should be able to add a value to the third row", ->
         row3 = @sht.get('rows').at(2)
         expect(row3.has('Field1')).toBeFalsy()
         row3.set({'Field1': 'froggies'})
         expect(row3.get('Field1')).toEqual 'froggies'
         # expect(row3.Field1?).toBeFalsy()
         # row3.Field1 = 'froggies'
         # expect(row3.Field1).toEqual 'froggies'
         
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
         expect(col2.get("editor")).toBe null



describe "Row", ->
   
   it "creates a row with initial value", ->
      val =
         id: 'decaf00005'
      row = new StoredSheet.Row(val)
      expect(row).toBeTruthy()
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
      expect(rows).toBeTruthy()
      expect(rows.constructor.name).toEqual 'Rows'
      row = rows.at(0)
      expect(row.constructor.name).toEqual 'Row'      
      expect(row.get 'id').toEqual 'decaf00005'
   

describe "Column", ->
   

describe "Columns", ->
   


