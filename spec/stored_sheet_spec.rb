require File.dirname(__FILE__) + '/spec_helper'

describe "Stored Sheet" do

   describe "Data Model" do

      describe "Sheet" do

         describe "creation" do
 
            it "creates a sheet" do
               Sheet.count.should == 0
               sheet = Sheet.new_sheet
               sheet.save
               Sheet.count.should == 1
            end
         
            it "creates a sheet with a custom name" do
               Sheet.count.should == 0
               Sheet.new_sheet("Sheet One").save
               sheet = Sheet.first
               sheet.sheet_name.should == "Sheet One"
            end
            
            it "creates a sheet with 12 columns" do
               sheet = Sheet.new_sheet("12 cols sheet",num_cols = 12)
               sheet.save
               sheet.columns.count.should == 12
               lastcol = sheet.columns.last
               lastcol.name.should == "L"
               # abcdefghijklmno
               # 123456789012
               lastcol.field.should == "Field12"
            end

            it "creates a sheet with 27 columns" do
               sheet = Sheet.new_sheet("27 cols sheet",num_cols = 27)
               sheet.save
               sheet.columns.count.should == 27
               lastcol = sheet.columns.last
               lastcol.name.should == "AA"
               lastcol.field.should == "Field27"
            end

            it "creates a sheet with 12 rows" do
               sheet = Sheet.new_sheet("12 rows sheet", 3,num_rows = 12)
               sheet.save
               sheet.rows.count.should == 12
            end

         end
         
         describe "modification" do
            before :each do
               @sheet = Sheet.new_sheet("Modify Me", 3, 3)
               @sheet.save
            end
            
            it "sets a cell's value" do
               @sheet[1,1].should == nil
               @sheet[1,1] = "testing"
               @sheet[1,1].should == "testing"
            end
            
            it "fails for out of range column index" do
               expect { a = @sheet[1, 5] }.to raise_error(IndexError, 'column index (5) out of range (0..2)')
               expect { @sheet[1, 5] = "a" }.to raise_error(IndexError, 'column index (5) out of range (0..2)')
            end
            
            it "fails for out of range row index" do
               expect { a = @sheet[5, 1] }.to raise_error(IndexError, 'row index (5) out of range (0..2)')
               expect { @sheet[5, 1] = "a" }.to raise_error(IndexError, 'row index (5) out of range (0..2)')
            end
            
            def loop_all
               (0..2).each do |r|
                  (0..2).each do |c|
                     yield [r, c]
                  end
               end
            end
            
            it "sets all the cells' values (hard loop)" do
               loop_all {|r, c| @sheet[r,c].should == nil }
               loop_all {|r, c| @sheet[r,c] = "test" }
               cell_count = 0
               loop_all {|r, c| @sheet[r,c].should == "test"; cell_count += 1 }
               cell_count.should == 9
            end
            
            it "sets all the cells' values (each_cell_index)" do
               @sheet.each_cell_index {|r, c| @sheet[r,c].should == nil }
               @sheet.each_cell_index {|r, c| @sheet[r,c] = "test" }
               cell_count = 0
               @sheet.each_cell_index {|r, c| @sheet[r,c].should == "test"; cell_count += 1 }
               cell_count.should == 9
            end
         end
         
      end
   end

   describe "Basic Sinatra/Rspec Setup" do

      it "should respond to /" do
         get '/'
         last_response.should be_ok
      end

      it "should return the correct content-type when viewing root" do
         get '/'
         last_response.headers["Content-Type"].should include("text/html")
      end

      it "should return 404 when page cannot be found" do
         get '/404'
         last_response.status.should == 404
      end

   end

   describe "general web interface", type: :request do
      
      describe "GET /" do

         it "should return welcome page when viewing root" do
            get '/'
            last_response.body.should include("Welcome to the Stored Sheet Demo!")
         end
      
      end

      describe "GET /shts" do
         
         before :each do
            %w{SheetOne SheetTwo SheetThree}.each do |s|
               sheet = Sheet.new_sheet(s)
               sheet.save
            end
         end

         it "should display sheets list (rspec)" do
            get '/shts'
            last_response.should be_ok
            last_response.body.should include('SheetTwo')
         end

         it "should display sheets list (capybara)" do
            visit '/shts'
            page.should have_content('SheetOne')
            page.should have_content('SheetTwo')
            page.should have_content('SheetThree')
         end
         
      end

      describe "new sheet" do
         it "creates a new sheet (rspec)" do
            Sheet.count.should == 0
            get '/shts/new'
            follow_redirect!
            Sheet.count.should == 1
            sheet_id = Sheet.first.id.to_s
            last_response.body.should include(sheet_id)
         end
         
         it "creates a new sheet (capybara)" do
            Sheet.count.should == 0
            visit '/'
            page.find(".start_button[contains('New Sheet')]").click
            Sheet.count.should == 1
            sheet_id = Sheet.first.id.to_s
            page.should have_content(sheet_id)
         end
         
         it "creates a new sheet from All Sheets page" do
            Sheet.count.should == 0
            visit '/shts'
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
               visit "/shts/#{@sheet.id}"
               page.should have_content(@sheet.id)
            end
            
            it "displays an editable sheet name like a title" do
               visit "/shts/#{@sheet.id}"
               page.find('h1 input[type=text]#sheet_name').value.should == 'Sheet One'
            end
            
            it "has a save button" do
               visit "/shts/#{@sheet.id}"
               page.should have_button('Save')
            end
            
            describe "grid display", js: true do
               before :each do
                  fill_default_sheet @sheet
               end
               
               it "displays the same number of columns as in the sheet" do
                  visit "/shts/#{@sheet.id}"
                  colheaders = page.all('.slick-header-columns .slick-column-name')
                  colheaders.count.should == @sheet.columns.count
                  colheaders.last.should have_content(@sheet.columns.last.name)
               end
            
               it "displays the rows" do
                  visit "/shts/#{@sheet.id}"

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
               visit "/shts/#{@sheet.id}"
               fill_in 'sheet_name', with: 'Leaping Frog Bellies'
               click_button 'Save'
               page.find('.status').text.should == 'success' # This seems to have been necessary because I think it makes the test engine wait for the save to finish
               savedsheet = Sheet.find(@sheet.id)
               savedsheet.sheet_name.should == 'Leaping Frog Bellies'
               visit "/shts/#{@sheet.id}"
               page.find('input[type=text]#sheet_name').value.should == 'Leaping Frog Bellies'
            end
            
            it "should change some cell data"
            
         end
         
      end

   end

end
