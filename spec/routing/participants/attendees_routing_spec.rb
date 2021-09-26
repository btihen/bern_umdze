require "rails_helper"

RSpec.describe Participants::AttendancesController, type: :routing do
  describe "routing" do
    it "routes to #edit" do
      expect(get: "/participants/attendances?reservation_id=1&location=onsite").to route_to("participants/attendances#edit", reservation_id: "1", location: "onsite")
    end
  end
end
