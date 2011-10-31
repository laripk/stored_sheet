# note: guard-jasmine, or maybe jasminerice, will only recognize the first describe in a spec file for running individual files
describe "Column & Columns", ->

   describe "Column jasmine hookup", ->

      it "can create a Column", ->
         col = new StoredSheet.Models.Column()
         expect(col).toBeTruthy()
   
      it "can create a Columns", ->
         cols = new StoredSheet.Collections.Columns()
         expect(cols).toBeTruthy()


   describe "Column", ->
      beforeEach ->
         @val =
            id: 'decaf00001'
            name: 'A'
            num: 1
            field: 'Field1'
            width: 100
         @col = new StoredSheet.Models.Column(@val)
         
   
      it "creates a column with initial value", ->
         expect(@col?).toBeTruthy()
         expect(@col.constructor.name).toEqual 'Column'
         expect(@col.id).toEqual 'decaf00001'
         expect(@col['name']).toEqual 'A'
         expect(@col['field']).toEqual 'Field1'
         expect(@col['width']).toEqual 100

      it "should clientize", ->
         expect(@col['editor']).toBe TextCellEditor

      it "should serverize", ->
         expect(@col.toJSON()['editor']?).toBeFalsy()

      it "should JSONify properly", ->
         json = 
            id: 'decaf00001'
            name: 'A'
            num: 1
            field: 'Field1'
            width: 100
         expect(@col.toJSON()).toEqual json




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
         cols = new StoredSheet.Collections.Columns(val)
         expect(cols?).toBeTruthy()
         expect(cols.constructor.name).toEqual 'Columns'
         col = cols.at(0)
         expect(col.constructor.name).toEqual 'Column'
         expect(col.id).toEqual 'decaf00001'
         expect(col['name']).toEqual 'A'
         expect(col['field']).toEqual 'Field1'
         expect(col['width']).toEqual 100
      


