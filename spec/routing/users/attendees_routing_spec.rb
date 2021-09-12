require "rails_helper"

RSpec.describe Users::AttendancesController, type: :routing do
  describe "routing" do
    # it "routes to #index" do
    #   expect(get: "/users/attendances").to route_to("users/attendances#index")
    # end

    it "routes to #new" do
      expect(get: "/users/attendances/new").to route_to("users/attendances#new")
    end

    # it "routes to #show" do
    #   expect(get: "/users/attendances/1").to route_to("users/attendances#show", id: "1")
    # end

    it "routes to #edit" do
      expect(get: "/users/attendances/1/edit").to route_to("users/attendances#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/users/attendances").to route_to("users/attendances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/users/attendances/1").to route_to("users/attendances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/users/attendances/1").to route_to("users/attendances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/attendances/1").to route_to("users/attendances#destroy", id: "1")
    end
  end
end
