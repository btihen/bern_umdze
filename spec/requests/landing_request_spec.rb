require 'rails_helper'

RSpec.describe "Landings", type: :request do

  describe "GET /index" do
    it "'/landing' returns http success" do
      get "/landing"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    end
    it "'landing_path' returns http success" do
      get landing_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    end
    it "'/' returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    end
    it "'root_path' returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    end
    # it "'/landing/index' returns http success" do
    #   get "/landing/index"
    #   expect(response).to have_http_status(:success)
    #   expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    # end
    # it "'landing_index_path' returns http success" do
    #   get landing_index_path
    #   expect(response).to have_http_status(:success)
    #   expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    # end
  end

end