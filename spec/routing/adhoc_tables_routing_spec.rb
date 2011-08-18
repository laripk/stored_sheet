require "spec_helper"

describe AdhocTablesController do
  describe "routing" do

    it "routes to #index" do
      get("/adhoc_tables").should route_to("adhoc_tables#index")
    end

    it "routes to #new" do
      get("/adhoc_tables/new").should route_to("adhoc_tables#new")
    end

    it "routes to #show" do
      get("/adhoc_tables/1").should route_to("adhoc_tables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adhoc_tables/1/edit").should route_to("adhoc_tables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adhoc_tables").should route_to("adhoc_tables#create")
    end

    it "routes to #update" do
      put("/adhoc_tables/1").should route_to("adhoc_tables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adhoc_tables/1").should route_to("adhoc_tables#destroy", :id => "1")
    end

  end
end
