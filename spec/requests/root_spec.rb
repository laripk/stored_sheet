require 'spec_helper'

describe "root" do

   describe "GET '/'" do
     
      it "should respond to /" do
         get '/'
         response.should be_success
      end

      it "should return the correct content-type when viewing root" do
         get '/'
         response.headers["Content-Type"].should include("text/html")
      end

      it "should return welcome page when viewing root" do
         get '/'
         response.body.should include("Welcome to the Stored Sheet Demo!")
      end

   end

end
