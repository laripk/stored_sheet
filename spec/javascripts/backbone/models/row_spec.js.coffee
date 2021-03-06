# note: guard-jasmine, or maybe jasminerice, will only recognize the first describe in a spec file for running individual files
describe "Row & Rows", ->

   describe "jasmine hookup", ->

      it "can create a Row", ->
         rw = new StoredSheet.Models.Row()
         expect(rw).toBeTruthy()
   
      it "can create a Rows", ->
         rws = new StoredSheet.Collections.Rows()
         expect(rws).toBeTruthy()



   describe "Row", ->
      beforeEach ->
         @val =
            id: 'decaf00005'
         @row = new StoredSheet.Models.Row(@val)
         
   
      it "creates a row with initial value", ->
         expect(@row?).toBeTruthy()
         expect(@row.constructor.name).toEqual 'Row'
         expect(@row.id).toEqual 'decaf00005'
   
      it "sets a field value", ->
         expect(@row.get('Field1')).toBeUndefined()
         @row.set {Field1: 'wombats'}
         expect(@row.get('Field1')).toEqual 'wombats'
         

   describe "Rows", ->

      it "creates a row list with initial value", ->
         val = [
            id: 'decaf00005'
         ,
            id: 'decaf00006'
         ,
            id: 'decaf00007'
         ]
         rows = new StoredSheet.Collections.Rows(val)
         expect(rows?).toBeTruthy()
         expect(rows.constructor.name).toEqual 'Rows'
         row = rows.at(0)
         expect(row.constructor.name).toEqual 'Row'      
         expect(row.id).toEqual 'decaf00005'
   

