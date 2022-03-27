# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page Features without a login', type: :feature do
  scenario 'Visit landing Page' do
    visit landing_path

    expect(page).to  have_http_status(:success)
    expect(current_path).to eq(landing_path)
    page_tag = find('p#landing_index', text: 'Landing Index', visible: false)
    expect(page_tag).to be_truthy
  end

  describe 'logged in as viewer' do
    let(:user) { FactoryBot.create :user }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'landing_path is reachable by user when wanted' do
      visit landing_path

      expect(page).to  have_http_status(:success)
      expect(current_path).to eq(landing_path)
      page_tag = find('p#landing_index', text: 'Landing Index', visible: false)
      expect(page_tag).to be_truthy
    end
  end
end
