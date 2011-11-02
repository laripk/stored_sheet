require 'spec_helper'

describe SheetsController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_redirect
    end
  end
  
  describe "has a sheet" do
     before :each do
        @sheet = Sheet.new_sheet
        @sheet.save
     end

      describe "GET 'show'" do
         it "returns http success" do
            get :show, id: @sheet.id
            response.should be_success
         end
      end

      describe "PUT 'update'" do
         it "returns http success" do
            put :update, { id: @sheet.id, sheet: {} }
            response.should be_success
         end
      end
  
  end

end
