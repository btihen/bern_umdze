require 'rails_helper'

RSpec.describe "Hosts::Homes", type: :request do

  xdescribe "GET /index" do
    it "returns http success" do
      get "/hosts/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
