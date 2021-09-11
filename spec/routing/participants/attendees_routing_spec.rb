require "rails_helper"

RSpec.describe Participants::AttendeesController, type: :routing do
  describe "routing" do
    # it "routes to #index" do
    #   expect(get: "/participants/attendees").to route_to("participants/attendees#index")
    # end

    it "routes to #new" do
      expect(get: "/participants/attendees/new").to route_to("participants/attendees#new")
    end

    # it "routes to #show" do
    #   expect(get: "/participants/attendees/1").to route_to("participants/attendees#show", id: "1")
    # end

    it "routes to #edit" do
      expect(get: "/participants/attendees/1/edit").to route_to("participants/attendees#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/participants/attendees").to route_to("participants/attendees#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/participants/attendees/1").to route_to("participants/attendees#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/participants/attendees/1").to route_to("participants/attendees#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/participants/attendees/1").to route_to("participants/attendees#destroy", id: "1")
    end
  end
end
