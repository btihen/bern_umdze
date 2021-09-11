require 'rails_helper'

RSpec.describe "route '/participants/attends", type: :request do

  let(:participant)  { FactoryBot.create :participant }
  before do
    sign_in host
  end
  after do
    sign_out host
  end

  xdescribe "'attend' create" do

    scenario 'returns success for hosts homepage with the agenda' do
      get root_path

      expect(response).to  have_http_status(:success)
      expect(response.body).to include("<p hidden id='host_home' class='pageName'>Host-#{host.id} Home</p>")
    end
  end

  xdescribe "'attend' delete" do

    scenario 'returns success for hosts homepage with the agenda' do
      get root_path

      expect(response).to  have_http_status(:success)
      expect(response.body).to include("<p hidden id='host_home' class='pageName'>Host-#{host.id} Home</p>")
    end
  end

end
