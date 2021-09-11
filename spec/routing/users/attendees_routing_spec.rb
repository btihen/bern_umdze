require "rails_helper"

RSpec.describe Users::AttendeesController, type: :routing do
  describe "routing" do
    # it "routes to #index" do
    #   expect(get: "/users/attendees").to route_to("users/attendees#index")
    # end

    it "routes to #new" do
      expect(get: "/users/attendees/new").to route_to("users/attendees#new")
    end

    # it "routes to #show" do
    #   expect(get: "/users/attendees/1").to route_to("users/attendees#show", id: "1")
    # end

    it "routes to #edit" do
      expect(get: "/users/attendees/1/edit").to route_to("users/attendees#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/users/attendees").to route_to("users/attendees#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/attendees/1").to route_to("users/attendees#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/attendees/1").to route_to("users/attendees#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/attendees/1").to route_to("users/attendees#destroy", id: "1")
    end
  end
end
