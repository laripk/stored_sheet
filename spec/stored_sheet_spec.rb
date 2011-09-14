require File.dirname(__FILE__) + '/spec_helper'

describe "Stored Sheet" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  describe "Basic Application Setup" do
  
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
  
     it "should return 'Welcome to the Stored Sheet Demo!' when viewing root" do
       get '/'
       last_response.body.should include("Welcome to the Stored Sheet Demo!")
     end
  end
end
