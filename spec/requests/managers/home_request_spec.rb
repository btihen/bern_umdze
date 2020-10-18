require 'rails_helper'

RSpec.describe "Managers::Home - route '/'", type: :request do

  describe "logged in as manager" do
    let(:manager)  { FactoryBot.create :user, access_role: "manager" }
    before do
      sign_in manager
    end
    after do
      sign_out manager
    end

    scenario 'return success for managers homepage with the Agenda' do
      get root_path

      expect(response).to  have_http_status(:success)
      expect(response.body).to include("<p hidden id='manager_home' class='pageName'>Manager-#{manager.id} Home</p>")
    end
  end

end
