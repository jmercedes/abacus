require "rails_helper"

RSpec.describe Admin::RequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/requests").to route_to("admin/requests#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/requests/new").to route_to("admin/requests#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/requests/1").to route_to("admin/requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/requests/1/edit").to route_to("admin/requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/requests").to route_to("admin/requests#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/requests/1").to route_to("admin/requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/requests/1").to route_to("admin/requests#destroy", :id => "1")
    end

  end
end
