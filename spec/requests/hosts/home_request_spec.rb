require 'rails_helper'

RSpec.describe "route '/' (for hosts)", type: :request do

  describe "'host' logged in" do
    let(:host)  { FactoryBot.create :user, access_role: "host" }
    before do
      sign_in host
    end
    after do
      sign_out host
    end

    scenario 'returns success for hosts homepage with the agenda' do
      get root_path

      expect(response).to  have_http_status(:success)
      expect(response.body).to include("<p hidden id='host_home' class='pageName'>Host-#{host.id} Home</p>")
    end
  end

end
