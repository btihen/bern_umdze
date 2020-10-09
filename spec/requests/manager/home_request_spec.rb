require 'rails_helper'

RSpec.describe "Managers::Homes", type: :request do

  xdescribe "GET /index" do
    it "returns http success" do
      get "/managers/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
