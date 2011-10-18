require 'spec_helper'

describe Sheet do

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
