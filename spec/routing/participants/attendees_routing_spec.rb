require "rails_helper"

RSpec.describe Participants::AttendancesController, type: :routing do
  describe "routing" do
    # it "routes to #index" do
    #   expect(get: "/participants/attendances").to route_to("participants/attendances#index")
    # end

    it "routes to #new" do
      expect(get: "/participants/attendances/new").to route_to("participants/attendances#new")
    end

    # it "routes to #show" do
    #   expect(get: "/participants/attendances/1").to route_to("participants/attendances#show", id: "1")
    # end

    it "routes to #edit" do
      expect(get: "/participants/attendances/1/edit").to route_to("participants/attendances#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/participants/attendances").to route_to("participants/attendances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/participants/attendances/1").to route_to("participants/attendances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/participants/attendances/1").to route_to("participants/attendances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/participants/attendances/1").to route_to("participants/attendances#destroy", id: "1")
    end
  end
end
