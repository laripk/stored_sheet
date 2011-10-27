# note: guard-jasmine, or maybe jasminerice, will only recognize the first describe in a spec file for running individual files
describe "Sheet", ->

   describe "jasmine hookup", ->

      it "can create a Sheet", ->
         sht = new StoredSheet.Models.Sheet()
         expect(sht).toBeTruthy()
   
   describe "creation", ->
      
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
         @sht = new StoredSheet.Models.Sheet @samplesheet

   
      describe "initialized from server data", ->
      
         it "should be a Sheet", ->
            expect(@sht.constructor.name).toEqual 'Sheet'
   
         it "should have the sheet_name", ->
            expect(@sht.get "sheet_name").toEqual "Example Sheet"

         it "should have columns of type Columns", ->
            expect(@sht.get('columns').constructor.name).toEqual 'Columns'
               
         it "should have rows of type Rows", ->
            expect(@sht.get('rows').constructor.name).toEqual 'Rows'
               
         it "should have first column of type Column", ->
            expect(@sht.get('columns').at(0).constructor.name).toEqual 'Column'
               
         it "should have first row of type Row", ->
            expect(@sht.get('rows').at(0).constructor.name).toEqual 'Row'
      
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

   
         # it "should clientize second column", ->
         #    col2 = @sht.get('columns').at(1)
         #    # col2.clientize()
         #    expect(col2["editor"]).toBe TextCellEditor
         #    
         # it "should serverize second column", ->
         #    col2 = @sht.get('columns').at(1)
         #    # col2.serverize()
         #    expect(col2.toJSON()['editor']?).toBeFalsy()
         #    
         # it "should clientize the sheet", ->
         #    # @sht.clientize()
         #    expect(@sht.get('columns').at(1)["editor"]).toBe TextCellEditor
         #    
         # it "should serverize the sheet", ->
         #    # @sht.serverize()
         #    expect(@sht.toJSON()['columns'][1]['editor']?).toBeFalsy()
   
   
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
   
