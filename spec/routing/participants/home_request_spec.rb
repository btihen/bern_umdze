# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Participant Home', type: :request do
  # describe "GET /home - NOT loged-in" do
  #   it "returns http success" do
  #     get root_path

  #     expect(response).to have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
  #   end
  # end

  # describe "GET /home - logged in" do
  #   let(:user)  { FactoryBot.create :user }
  #   before do
  #     sign_in user
  #   end
  #   after do
  #     sign_out user
  #   end
  #   it "returns http success" do
  #     get root_path

  #     expect(response).to have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='viewer_home' class='pageName'>Viewer-#{user.id} Home</p>")
  #   end
  # end

  # scenario 'Visit Root Page - NOT logged is the landing_page' do
  #   get root_path

  #   expect(response).to  have_http_status(:success)
  #   expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
  # end

  # describe "logged in as viewer" do
  #   let(:user)  { FactoryBot.create :user, access_role: "viewer" }
  #   before do
  #     sign_in user
  #   end
  #   after do
  #     sign_out user
  #   end

  #   scenario 'root_path is homepage for viewer user' do
  #     get root_path

  #     expect(response).to  have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='viewer_home' class='pageName'>Viewer-#{user.id} Home</p>")
  #   end
  # end

  # describe "logged in as host" do
  #   let(:user)  { FactoryBot.create :user, access_role: "host" }
  #   before do
  #     sign_in user
  #   end
  #   after do
  #     sign_out user
  #   end

  #   scenario 'root_path is homepage for host user' do
  #     get root_path

  #     expect(response).to  have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='host_home' class='pageName'>Host-#{user.id} Home</p>")
  #   end
  # end

  # describe "logged in as planner" do
  #   let(:user)  { FactoryBot.create :user, access_role: "planner" }
  #   before do
  #     sign_in user
  #   end
  #   after do
  #     sign_out user
  #   end

  #   scenario 'root_path is homepage for planner user' do
  #     get root_path

  #     expect(response).to  have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='planner_home' class='pageName'>Planner-#{user.id} Home</p>")
  #   end
  # end

  # describe "logged in as manager" do
  #   let(:user)  { FactoryBot.create :user, access_role: "manager" }
  #   before do
  #     sign_in user
  #   end
  #   after do
  #     sign_out user
  #   end

  #   scenario 'root_path is homepage for manager user' do
  #     get root_path

  #     expect(response).to  have_http_status(:success)
  #     expect(response.body).to include("<p hidden id='manager_home' class='pageName'>Manager-#{user.id} Home</p>")
  #   end
  # end
end
