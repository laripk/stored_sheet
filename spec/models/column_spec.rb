require 'spec_helper'

describe Column do

   describe ".col_name()" do
      
      it "returns A for 1" do
         Column.col_name(1).should == 'A'
      end
      
      it "returns B for 2" do
         Column.col_name(2).should == 'B'
      end
      
      it "returns Z for 26" do
         Column.col_name(26).should == 'Z'
      end
      
      it "returns AA for 27" do
         Column.col_name(27).should == 'AA'
      end
      
      it "returns AC for 29" do
         Column.col_name(29).should == 'AC'
      end
      
      it "returns BC for 55" do
         Column.col_name(55).should == 'BC'
      end

   end
end
