require File.dirname(__FILE__) + '/spec_helper'

describe "Stored Sheet" do

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

   describe "Data Model" do
      describe "Sheet" do
         it "creates a sheet" do
            Sheet.count.should == 0
            sheet = Sheet.new_sheet
            sheet.save
            Sheet.count.should == 1
         end
         
         it "creates a sheet with a custom name" do
            Sheet.count.should == 0
            sheet = Sheet.new_sheet("Sheet One")
            sheet.save
            sheet = Sheet.first
            sheet.sheet_name.should == "Sheet One"
         end
         
         pending "modifying a sheet"
      end
   end

   describe "general web interface", :type => :request do
      
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

      describe "a sheet" do
         before :each do
            @sheet = Sheet.new_sheet("Sheet One")
            @sheet.save
         end
         
         describe "displays the sheet" do
            
            it "contains the sheet id" do
               visit "/shts/#{@sheet.id}"
               page.should have_content(@sheet.id)
            end
            
            it "displays an editable sheet name like a title" do
               visit "/shts/#{@sheet.id}"
               page.find('h1 input[type=text]#sheet_name').value.should == 'Sheet One'
            end
            
            it "displays the same number of columns as in the sheet", :js => true do
               visit "/shts/#{@sheet.id}"
               colheaders = page.all('.slick-header-columns .slick-column-name')
               colheaders.count.should == @sheet.columns.count
               colheaders.last.should have_content(@sheet.columns.last.name)
            end
            
            it "displays some rows", :js => true do
               pending "I don't know what I want to test here."
            end
            
         end
         
      end

   end

end
