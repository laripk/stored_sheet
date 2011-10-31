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

         it "should clientize second column", ->
            col2 = @sht.get('columns').at(1)
            # col2.clientize()
            expect(col2.get("editor")).toBe TextCellEditor

         it "should serverize second column", ->
            col2 = @sht.get('columns').at(1)
            # col2.serverize()
            expect(col2.toJSON()['editor']?).toBeFalsy()

         it "should clientize the sheet", ->
            # @sht.clientize()
            expect(@sht.get('columns').at(1).get("editor")).toBe TextCellEditor

         it "should serverize the sheet", ->
            # @sht.serverize()
            expect(@sht.toJSON()['columns'][1]['editor']?).toBeFalsy()


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
            expect(row3.get('Field1')?).toBeFalsy()
            row3.set {Field1: 'froggies'}
            expect(row3.get('Field1')).toEqual 'froggies'

         it "should trigger a change event when adding a cell value", ->
            what_changed = (obj) ->
               expect(obj.constructor.name).toEqual 'Row'
               expect(obj.changedAttributes()).toEqual {Field1: 'froggies'}
               # return [obj.constructor.name, obj.changedAttributes()]
            @sht.bind 'change', what_changed, @sht
            row3 = @sht.get('rows').at(2)
            row3.bind 'change', what_changed, row3
            expect(row3.get('Field1')?).toBeFalsy()
            row3.set {Field1: 'froggies'}
            # expect(row3.changedAttributes()).toEqual ['Field1']

      describe "saving & fetching", ->
         beforeEach ->
            jasmine.Ajax.useMock()
            @sht.get('rows').at(0).set {Field1: 'kitties'}
            @sht.get('rows').at(1).set {Field2: 'birdies'}
            @sht.get('rows').at(2).set {Field3: 'froggies'}


         it "should JSONify properly", ->
            jsonmod = {
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
            expect(@sht.toJSON()).toEqual jsonmod

         it "should have the correct url", ->
            expect(@sht.idAttribute).toEqual 'id'
            expect(@sht.get('id')).toEqual 'decaf00004'
            expect(@sht.id).toEqual 'decaf00004'
            expect(@sht.url()).toEqual '/sheets/decaf00004'

         it "should save successfully", ->
            jsonmodtxt = '{"sheet":{"sheet_name":"Example Sheet","id":"decaf00004","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}}'
            fakeGoodResponse =
               status: 200
               responseText: jsonmodtxt

            onSuccess = jasmine.createSpy('onSuccess')
            onFailure = jasmine.createSpy('onFailure')
            syncSpy = spyOn(Backbone, 'sync').andCallThrough()
            # sync2Spy = spyOn(StoredSheet.Models.Sheet, 'sync').andCallThrough()

            @sht.save({}, {success: onSuccess, error: onFailure})
            # @sht.save(@sht.toJSON(), {success: onSuccess, error: onFailure})
            req = mostRecentAjaxRequest()
            req.response fakeGoodResponse

            expect(onSuccess).toHaveBeenCalled()
            expect(onSuccess.mostRecentCall.args[2].statusText).toEqual 'success'
            # expect(onSuccess.mostRecentCall.args[0]).toEqual '' # sheet model
            # expect(onSuccess.mostRecentCall.args[1]).toEqual '' # data ?
            # expect(onSuccess.mostRecentCall.args[2]).toEqual '' # request
            # expect(onSuccess.mostRecentCall.args[3]).toEqual '' # undefined

            expect(req.method).toEqual 'PUT'
            expect(req.url).toEqual '/sheets/decaf00004'
            expect(req.params).toEqual jsonmodtxt

            # expect(sync2Spy).toHaveBeenCalled()
            # expect(sync2Spy.mostRecentCall.args[0]).toEqual 'update'
            expect(syncSpy).toHaveBeenCalled()
            expect(syncSpy.mostRecentCall.args[0]).toEqual 'update'

         it "should fail saving gracefully", ->
            jsonmodtxt = '{"sheet":{"sheet_name":"Example Sheet","id":"decaf00004","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}}'
            fakeBadResponse =
               status: 404
               responseText: jsonmodtxt

            onSuccess = jasmine.createSpy('onSuccess')
            onFailure = jasmine.createSpy('onFailure')
            syncSpy = spyOn(Backbone, 'sync').andCallThrough()
            # sync2Spy = spyOn(StoredSheet.Models.Sheet, 'sync').andCallThrough()

            @sht.save({}, {success: onSuccess, error: onFailure})
            # @sht.save(@sht.toJSON(), {success: onSuccess, error: onFailure})
            req = mostRecentAjaxRequest()
            req.response fakeBadResponse

            expect(onFailure).toHaveBeenCalled()
            expect(onFailure.mostRecentCall.args[1].statusText).toEqual 'error'
            # expect(onFailure.mostRecentCall.args[0]).toEqual '' # sheet model
            # expect(onFailure.mostRecentCall.args[1]).toEqual '' # request
            # expect(onFailure.mostRecentCall.args[2]).toEqual '' # options
            # expect(onFailure.mostRecentCall.args[3]).toEqual '' # undefined

            expect(req.method).toEqual 'PUT'
            expect(req.url).toEqual '/sheets/decaf00004'
            expect(req.params).toEqual jsonmodtxt

            # expect(sync2Spy).toHaveBeenCalled()
            # expect(sync2Spy.mostRecentCall.args[0]).toEqual 'update'
            expect(syncSpy).toHaveBeenCalled()
            expect(syncSpy.mostRecentCall.args[0]).toEqual 'update'

         it "should fetch", ->
            jsonmodparsed = {
               id : 'decaf00004',
               sheet_name : 'Example Sheet',
               columns : [
                  { id : 'decaf00001', name : 'A', num : 1, field : 'Field1', width : 100, editor : TextCellEditor },
                  { id : 'decaf00002', name : 'B', num : 2, field : 'Field2', width : 100, editor : TextCellEditor },
                  { id : 'decaf00003', name : 'C', num : 3, field : 'Field3', width : 100, editor : TextCellEditor }
               ],
               rows : [
                  { id : 'decaf00005', Field1 : 'kitties' },
                  { id : 'decaf00006', Field2 : 'birdies' },
                  { id : 'decaf00007', Field3 : 'froggies' }
               ]
            }
            jsonmodtxt = '{"sheet_name":"Example Sheet","id":"decaf00004","columns":[{"id":"decaf00001","name":"A","num":1,"field":"Field1","width":100},{"id":"decaf00002","name":"B","num":2,"field":"Field2","width":100},{"id":"decaf00003","name":"C","num":3,"field":"Field3","width":100}],"rows":[{"id":"decaf00005","Field1":"kitties"},{"id":"decaf00006","Field2":"birdies"},{"id":"decaf00007","Field3":"froggies"}]}'
            fakeGoodResponse =
               status: 200
               responseText: jsonmodtxt

            onSuccess = jasmine.createSpy('onSuccess')
            onFailure = jasmine.createSpy('onFailure')
            sht2 = new StoredSheet.Models.Sheet(@samplesheet)

            sht2.fetch({success: onSuccess, error: onFailure})
            req = mostRecentAjaxRequest()
            req.response fakeGoodResponse

            expect(onSuccess).toHaveBeenCalled()
            expect(onSuccess.mostRecentCall.args.length).toEqual 2
            # expect(onSuccess.mostRecentCall.args[0]).toEqual '' # model
            expect(onSuccess.mostRecentCall.args[1]).toEqual jsonmodparsed # parsed response

            expect(req.method).toEqual 'GET'
            expect(req.url).toEqual '/sheets/decaf00004'
            expect(req.params).toEqual null

            expect(sht2.get('rows').at(0).get('Field1')).toEqual 'kitties'
            expect(sht2.get('rows').at(1).get('Field2')).toEqual 'birdies'
            expect(sht2.get('rows').at(2).get('Field3')).toEqual 'froggies'

      describe "accessability for SlickGrid", ->

         it "works with 'columns[i]'", ->
            cols_param = @sht.get('columns').models
            # expect(cols_param[0]).toEqual ''
            expect(cols_param[0].id).toEqual 'decaf00001'
            expect(cols_param[0].name).toEqual 'A'
            expect(cols_param[0].width).toEqual 100
            expect(cols_param[0].field).toEqual 'Field1'
