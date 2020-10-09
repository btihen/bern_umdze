require "rails_helper"

RSpec.describe Managers::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/managers/users").to route_to("managers/users#index")
    end

    it "routes to #new" do
      expect(get: "/managers/users/new").to route_to("managers/users#new")
    end

    it "routes to #show" do
      expect(get: "/managers/users/1").to route_to("managers/users#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/managers/users/1/edit").to route_to("managers/users#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/managers/users").to route_to("managers/users#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/managers/users/1").to route_to("managers/users#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/managers/users/1").to route_to("managers/users#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/managers/users/1").to route_to("managers/users#destroy", id: "1")
    end
  end
end
