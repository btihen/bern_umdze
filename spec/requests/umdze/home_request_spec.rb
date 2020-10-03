require 'rails_helper'

RSpec.describe "Umdzes::Homes", type: :request do

  xdescribe "GET /index" do
    it "returns http success" do
      get "/umdzes/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
