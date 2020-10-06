require 'rails_helper'

RSpec.describe "Members::Homes", type: :request do

  xdescribe "GET /index" do
    it "returns http success" do
      get "/members/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end