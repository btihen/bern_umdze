require "rails_helper"

RSpec.describe Participants::MagicLinksController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(get: "/participants/magic_links/new").to route_to("participants/magic_links#new")
    end

    it "routes to #create" do
      expect(post: "/participants/magic_links").to route_to("participants/magic_links#create")
    end

  end
end
