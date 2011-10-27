
describe "jasmine hookup", ->

   it "sees the StoredSheet namespace", ->
      ss = StoredSheet
      expect(ss).toBeTruthy()
      # expect(ss).toEqual '' # for taking a peek inside; not what I really expect

#    describe "modification", ->
#       
#       it "should be able to add a value to the third row", ->
#          row3 = @sht.get('rows').at(2)
#          expect(row3['Field1']?).toBeFalsy()
#          row3['Field1'] = 'froggies'
#          expect(row3['Field1']).toEqual 'froggies'
#          
#       it "should trigger a change event when adding a cell value", ->
#          what_changed = (obj) ->
#             expect(obj.constructor.name).toEqual 'Row'
#             expect(obj.changedAttributes()).toEqual {Field1: 'froggies'}
#             # return [obj.constructor.name, obj.changedAttributes()]
#          @sht.bind 'change', what_changed, @sht
#          row3 = @sht.get('rows').at(2)
#          row3.bind 'change', what_changed, row3
#          expect(row3['Field1']?).toBeFalsy()
#          row3['Field1'] = 'froggies'
#          # expect(row3.changedAttributes()).toEqual ['Field1']
#    
#    describe "saving & fetching", ->
#       beforeEach ->
#          jasmine.Ajax.useMock()
#          @sht.get('rows').at(0)['Field1'] = 'kitties'
#          @sht.get('rows').at(1)['Field2'] = 'birdies'
#          @sht.get('rows').at(2)['Field3'] = 'froggies'
#          @jsonmod = { 
#             id : 'decaf00004', 
#             sheet_name : 'Example Sheet', 
#             columns : [ 
#                { id : 'decaf00001', name : 'A', num : 1, field : 'Field1', width : 100 }, 
#                { id : 'decaf00002', name : 'B', num : 2, field : 'Field2', width : 100 }, 
#                { id : 'decaf00003', name : 'C', num : 3, field : 'Field3', width : 100 } 
#             ], 
#             rows : [ 
#                { id : 'decaf00005', Field1 : 'kitties' }, 
#                { id : 'decaf00006', Field2 : 'birdies' }, 
#                { id : 'decaf00007', Field3 : 'froggies' } 
#             ] 
#          }
#          @jsonmodparsed = { 
#             id : 'decaf00004', 
#             sheet_name : 'Example Sheet', 
#             columns : [ 
#                { id : 'decaf00001', name : 'A', num : 1, field : 'Field1', width : 100, editor : TextCellEditor }, 
#                { id : 'decaf00002', name : 'B', num : 2, field : 'Field2', width : 100, editor : TextCellEditor }, 
#                { id : 'decaf00003', name : 'C', num : 3, field : 'Field3', width : 100, editor : TextCellEditor } 
#             ], 
#             rows : [ 
#                { id : 'decaf00005', Field1 : 'kitties' }, 
#                { id : 'decaf00006', Field2 : 'birdies' }, 
#                { id : 'decaf00007', Field3 : 'froggies' } 
#             ] 
#          }
#          @jsonmodtxt = '{"id":"decaf00004","sheet_name":"Example Sheet","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}'
#          @fakeGoodResponse =
#             status: 200
#             responseText: @jsonmodtxt
#          @fakeBadResponse =
#             status: 404
#             responseText: @jsonmodtxt
#          
#       
#       it "should JSONify properly", ->
#          expect(@sht.toJSON()).toEqual @jsonmod
#       
#       it "should save successfully", ->
#          onSuccess = jasmine.createSpy('onSuccess')
#          onFailure = jasmine.createSpy('onFailure')
#          syncSpy = spyOn(Backbone, 'sync').andCallThrough()
#          sync2Spy = spyOn(StoredSheet.Models.Sheet, 'sync').andCallThrough()
#          
#          @sht.save({}, {success: onSuccess, error: onFailure})
#          # @sht.save(@sht.toJSON(), {success: onSuccess, error: onFailure})
#          req = mostRecentAjaxRequest()
#          req.response @fakeGoodResponse
#          
#          expect(onSuccess).toHaveBeenCalled()
#          expect(onSuccess.mostRecentCall.args[2].statusText).toEqual 'success'
#          # expect(onSuccess.mostRecentCall.args[0]).toEqual '' # sheet model
#          # expect(onSuccess.mostRecentCall.args[1]).toEqual '' # data ?
#          # expect(onSuccess.mostRecentCall.args[2]).toEqual '' # request
#          # expect(onSuccess.mostRecentCall.args[3]).toEqual '' # undefined
# 
#          expect(req.method).toEqual 'POST'
#          expect(req.url).toEqual '/shts/decaf00004'
#          expect(req.params).toEqual @jsonmodtxt
# 
#          expect(sync2Spy).toHaveBeenCalled()
#          expect(sync2Spy.mostRecentCall.args[0]).toEqual 'update'
#          expect(syncSpy).toHaveBeenCalled()
#          expect(syncSpy.mostRecentCall.args[0]).toEqual 'update'
#       
#       it "should fail saving gracefully", ->
#          onSuccess = jasmine.createSpy('onSuccess')
#          onFailure = jasmine.createSpy('onFailure')
#          syncSpy = spyOn(Backbone, 'sync').andCallThrough()
#          sync2Spy = spyOn(StoredSheet.Models.Sheet, 'sync').andCallThrough()
# 
#          @sht.save({}, {success: onSuccess, error: onFailure})
#          # @sht.save(@sht.toJSON(), {success: onSuccess, error: onFailure})
#          req = mostRecentAjaxRequest()
#          req.response @fakeBadResponse
# 
#          expect(onFailure).toHaveBeenCalled()
#          expect(onFailure.mostRecentCall.args[1].statusText).toEqual 'error'
#          # expect(onFailure.mostRecentCall.args[0]).toEqual '' # sheet model
#          # expect(onFailure.mostRecentCall.args[1]).toEqual '' # request
#          # expect(onFailure.mostRecentCall.args[2]).toEqual '' # options
#          # expect(onFailure.mostRecentCall.args[3]).toEqual '' # undefined
# 
#          expect(req.method).toEqual 'POST'
#          expect(req.url).toEqual '/shts/decaf00004'
#          expect(req.params).toEqual @jsonmodtxt
# 
#          expect(sync2Spy).toHaveBeenCalled()
#          expect(sync2Spy.mostRecentCall.args[0]).toEqual 'update'
#          expect(syncSpy).toHaveBeenCalled()
#          expect(syncSpy.mostRecentCall.args[0]).toEqual 'update'
# 
#       it "should fetch", ->
#          onSuccess = jasmine.createSpy('onSuccess')
#          onFailure = jasmine.createSpy('onFailure')
#          sht2 = new StoredSheet.Models.Sheet(@samplesheet)
#          
#          sht2.fetch({success: onSuccess, error: onFailure})
#          req = mostRecentAjaxRequest()
#          req.response @fakeGoodResponse
#          
#          expect(onSuccess).toHaveBeenCalled()
#          expect(onSuccess.mostRecentCall.args.length).toEqual 2
#          # expect(onSuccess.mostRecentCall.args[0]).toEqual '' # model
#          expect(onSuccess.mostRecentCall.args[1]).toEqual @jsonmodparsed # parsed response
# 
#          expect(req.method).toEqual 'GET'
#          expect(req.url).toEqual '/shts/decaf00004'
#          expect(req.params).toEqual null
#          
#          expect(sht2.get('rows').at(0)['Field1']).toEqual 'kitties'
#          expect(sht2.get('rows').at(1)['Field2']).toEqual 'birdies'
#          expect(sht2.get('rows').at(2)['Field3']).toEqual 'froggies'
# 
#    describe "accessability for SlickGrid", ->
#       
#       it "works with 'columns[i]'", ->
#          cols_param = @sht.get('columns').models
#          # expect(cols_param[0]).toEqual ''
#          expect(cols_param[0].id).toEqual 'decaf00001'
#          expect(cols_param[0].name).toEqual 'A'
#          expect(cols_param[0].width).toEqual 100
#          expect(cols_param[0].field).toEqual 'Field1'
# 
#          
# 
