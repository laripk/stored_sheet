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

  describe "general" do

     it "should return welcome page when viewing root" do
       get '/'
       last_response.body.should include("Welcome to the Stored Sheet Demo!")
     end
     
     it "should display sheets list" do
       get '/shts'
       last_response.should be_ok
       last_response.body.should 
     end
     
  end

end
