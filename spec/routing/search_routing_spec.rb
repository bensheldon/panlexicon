require "spec_helper"

describe SearchController do
  describe "routing" do
    it "routes to #index" do
      get("/search").should route_to("search#show")
    end

    it "routes to #show" do
      get("/search/lion,tiger").should route_to("search#show", :query => "lion,tiger")
    end

    it "routes to #show" do
      get("/search/?query=lion,tiger").should route_to("search#show", :query => "lion,tiger")
    end

    it "routes to #show" do
      get("/search/?q=lion,tiger").should route_to("search#show", :q => "lion,tiger")
    end

    it "routes to #create" do
      post("/search").should route_to("search#show")
    end
  end
end
