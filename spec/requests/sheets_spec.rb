require 'spec_helper'

describe "Sheets" do

  describe "GET /sheets" do

    before :each do
       %w{SheetOne SheetTwo SheetThree}.each do |s|
          sheet = Sheet.new_sheet(s)
          sheet.save
       end
    end

    it "is there" do
      get sheets_path
      response.status.should be(200)
    end

    it "should display sheets list (rspec)" do
       get sheets_path
       response.should be_ok
       response.body.should include('SheetTwo')
    end

    it "should display sheets list (capybara)" do
       visit sheets_path
       page.should have_content('SheetOne')
       page.should have_content('SheetTwo')
       page.should have_content('SheetThree')
    end

  end

  describe "new sheet" do

     it "creates a new sheet (rspec)" do
        Sheet.count.should == 0
        get new_sheet_path
        follow_redirect!
        Sheet.count.should == 1
        sheet_id = Sheet.first.id.to_s
        response.body.should include(sheet_id)
     end
     
     it "creates a new sheet (capybara)" do
        Sheet.count.should == 0
        visit root_path
        page.find(".start_button[contains('New Sheet')]").click
        Sheet.count.should == 1
        sheet_id = Sheet.first.id.to_s
        page.should have_content(sheet_id)
     end
     
     it "creates a new sheet from All Sheets page" do
        Sheet.count.should == 0
        visit sheets_path
        click_link "New Sheet"
        Sheet.count.should == 1
        sheet_id = Sheet.first.id.to_s
        page.should have_content(sheet_id)
     end

  end

  describe "viewing a sheet" do
     before :each do
        @sheet = Sheet.new_sheet("Sheet One")
        @sheet.save
     end
     
     def fill_default_sheet sht
        sht[0,0] = "aaa"
        sht[0,1] = "bbb"
        sht[0,2] = "ccc"
        
        sht[1,0] = "ddd"
        sht[1,1] = "eee"
        sht[1,2] = "fff"
        
        sht[2,0] = "ggg"
        sht[2,1] = "hhh"
        sht[2,2] = "iii"
        
        sht.save
     end
              
     describe "sheet display" do
        
        it "contains the sheet id" do
           visit sheet_path(@sheet)
           page.should have_content(@sheet.id)
        end
        
        it "displays an editable sheet name like a title" do
           visit sheet_path(@sheet)
           page.find('h1 input[type=text]#sheet_name').value.should == 'Sheet One'
        end
        
        it "has a save button" do
           visit sheet_path(@sheet)
           page.should have_button('Save')
        end
        
        describe "grid display", js: true do
           before :each do
              fill_default_sheet @sheet
           end
           
           it "displays the same number of columns as in the sheet" do
              visit sheet_path(@sheet)
              colheaders = page.all('.slick-header-columns .slick-column-name')
              colheaders.count.should == @sheet.columns.count
              colheaders.last.should have_content(@sheet.columns.last.name)
           end
        
           it "displays the rows" do
              visit sheet_path(@sheet)

              page.find('.slick-row[row="0"] .slick-cell.l0').should have_content('aaa')
              page.find('.slick-row[row="0"] .slick-cell.l1').should have_content('bbb')
              page.find('.slick-row[row="0"] .slick-cell.l2').should have_content('ccc')

              page.find('.slick-row[row="1"] .slick-cell.l0').should have_content('ddd')
              page.find('.slick-row[row="1"] .slick-cell.l1').should have_content('eee')
              page.find('.slick-row[row="1"] .slick-cell.l2').should have_content('fff')

              page.find('.slick-row[row="2"] .slick-cell.l0').should have_content('ggg')
              page.find('.slick-row[row="2"] .slick-cell.l1').should have_content('hhh')
              page.find('.slick-row[row="2"] .slick-cell.l2').should have_content('iii')
           end
        
        end
        
     end
     
     describe "sheet editing", js: true do
        before :each do
           fill_default_sheet @sheet
        end
        
        it "should change the sheet name" do
           @sheet.sheet_name.should == 'Sheet One'
           visit sheet_path(@sheet)
           fill_in 'sheet_name', with: 'Leaping Frog Bellies'
           click_button 'Save'
           page.find('.status').text.should == 'OK' # This seems to have been necessary because I think it makes the test engine wait for the save to finish; sometimes
           savedsheet = Sheet.find(@sheet.id)
           savedsheet.sheet_name.should == 'Leaping Frog Bellies'
           visit sheet_path(@sheet)
           page.find('input[type=text]#sheet_name').value.should == 'Leaping Frog Bellies'
        end
        
        it "should change some cell data" do
           visit sheet_path(@sheet)
           cel00 = page.find('.slick-row[row="0"] .slick-cell.l0')
           cel00.should have_content('aaa')
           cel00.click
           page.find('input.editor-text').set('Apple Berries')
           page.find('.slick-row[row="0"] .slick-cell.l1').click # note that grid currently needs edit to move off of changed cell for underlying object to update
           click_button 'Save'
           page.find('.status').text.should == 'OK'
           savedsheet = Sheet.find(@sheet.id)
           savedsheet[0,0].should == 'Apple Berries'
        end
        
        it "should see server updates on save" do
           pending "not ready for source control/multithreading thoughts yet"
           visit sheet_path(@sheet)
           page.find('.slick-row[row="1"] .slick-cell.l1').should have_content('eee')
           cel00 = page.find('.slick-row[row="0"] .slick-cell.l0')
           cel00.should have_content('aaa')
           cel00.click
           page.find('input.editor-text').set('Apple Berries')
           page.find('.slick-row[row="0"] .slick-cell.l1').click
           @sheet[1,1] = 'Frosted Flakes'
           @sheet.save
           click_button 'Save'
           page.find('.status').text.should == 'success'
           savedsheet = Sheet.find(@sheet.id)
           savedsheet[0,0].should == 'Apple Berries'
           savedsheet[1,1].should == 'Frosted Flakes'
           page.find('.slick-row[row="1"] .slick-cell.l1').should have_content('Frosted Flakes')
        end
        
     end
     
  end

end
