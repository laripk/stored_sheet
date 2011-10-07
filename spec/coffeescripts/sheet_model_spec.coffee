# storedsheet = require '../../public/app/sheet_model'
describe "jasmine hookup", ->
   it "sees the StoredSheet namespace", ->
      ss = StoredSheet
      expect(ss).toBeTruthy()

   # # this is here for taking a peek into the contents of StoredSheet,
   # # not for expecting it to be something in particular - comment out when not needed
   # it "sees something in the StoredSheet namespace", ->
   #    ss = StoredSheet
   #    expect(ss).toEqual ''

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

   it "can create a Sheet", ->
      sht = new StoredSheet.Sheet()
      expect(sht).toBeTruthy()

describe "Row", ->
   

describe "Rows", ->
   

describe "Column", ->
   

describe "Columns", ->
   

describe "Sheet", ->
   samplesheet = 
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
      # beforeEach ->
      #    @sht = new window.StoredSheet.Sheet samplesheet
      # 
      # it "should have the sheet_name", ->
      #    expect(@sht.get "sheet_name").toEqual "Example Sheet"
      #    
      # it "should have three columns", ->
      #    expect(@sht.columns.length).toEqual 3
   
   