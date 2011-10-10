describe "Grid jasmine hookup", ->

   it "sees the StoredSheet namespace", ->
      ss = StoredSheet
      expect(ss).toBeTruthy()
      # expect(ss).toEqual '' # for taking a peek inside; not what I really expect

   it "can create a NamedGrid", ->
      grd = new StoredSheet.NamedGrid()
      expect(grd).toBeTruthy()

