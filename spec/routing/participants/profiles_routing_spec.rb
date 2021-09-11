require "rails_helper"

RSpec.describe Participants::ProfilesController, type: :routing do
  describe "routing" do

    it "routes to #auth" do
      expect(get: "/participants/profiles/1/edit").to route_to("participants/profiles#edit", id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/participants/profiles/1").to route_to("participants/profiles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/participants/profiles/1").to route_to("participants/profiles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/participants/profiles/1").to route_to("participants/profiles#destroy", id: "1")
    end

  end
end
