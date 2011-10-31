describe "NamedGrid jasmine hookup", ->
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
      
   
   it "can create a NamedGrid", ->
      $('body').append("<form id='sheetform'><div id='mygrid'></div></form>")
      grd = new StoredSheet.Views.NamedGrid({model: @sht}) # doesn't work without a model passed in...
      expect(grd).toBeDefined()
   
   xit "should have more tests", ->
      pending()
   
   
   
   