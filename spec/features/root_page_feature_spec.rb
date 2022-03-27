# frozen_string_literal: true

# sign_in users(:bob)
# sign_in users(:bob), scope: :admin

# sign_out :user

require 'rails_helper'

RSpec.describe 'Root Page Features', type: :feature do
  scenario 'Visit Root Page - NOT logged is the landing_page' do
    visit root_path
    expect(page).to have_http_status(:success)

    expect(current_path).to eq('/')
    page_tag = find('p#landing_index', text: 'Landing Index', visible: false)
    expect(page_tag).to be_truthy
  end

  describe 'logged in as viewer' do
    let(:user) { FactoryBot.create :user, access_role: 'viewer' }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'root_path is homepage for viewer user' do
      visit root_path

      expect(page).to have_http_status(:success)
      expect(current_path).to eq(root_path)
      page_tag = find('p#viewer_home', text: "Viewer-#{user.id} Home", visible: false)
      expect(page_tag).to be_truthy
    end
  end

  describe 'logged in as host' do
    let(:user) { FactoryBot.create :user, access_role: 'host' }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'root_path is homepage for host user' do
      visit root_path

      expect(page).to have_http_status(:success)
      expect(current_path).to eq(root_path)
      page_tag = find('p#host_home', text: "Host-#{user.id} Home", visible: false)
      expect(page_tag).to be_truthy
    end
  end

  describe 'logged in as planner' do
    let(:user) { FactoryBot.create :user, access_role: 'planner' }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'root_path is homepage for planner user' do
      visit root_path

      expect(page).to have_http_status(:success)
      expect(current_path).to eq(root_path)
      page_tag = find('p#planner_home', text: "Planner-#{user.id} Home", visible: false)
      expect(page_tag).to be_truthy
    end
  end

  describe 'logged in as manager' do
    let(:user) { FactoryBot.create :user, access_role: 'manager' }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'root_path is homepage for manager user' do
      visit root_path

      expect(page).to have_http_status(:success)
      expect(current_path).to eq(root_path)
      page_tag = find('p#manager_home', text: "Manager-#{user.id} Home", visible: false)
      expect(page_tag).to be_truthy
    end
  end
end
