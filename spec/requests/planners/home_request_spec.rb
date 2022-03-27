# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "route '/' for planners", type: :request do
  describe 'logged in as planner' do
    let(:planner)  { FactoryBot.create :user, access_role: 'planner' }
    before do
      sign_in planner
    end
    after do
      sign_out planner
    end

    scenario 'returns success for planners homepage with the Agenda' do
      get root_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='planner_home' class='pageName'>Planner-#{planner.id} Home</p>")
    end
  end
end
