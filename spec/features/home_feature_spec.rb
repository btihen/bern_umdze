# sign_in users(:bob)
# sign_in users(:bob), scope: :admin

# sign_out :user

require 'rails_helper'

RSpec.describe 'Home Page Features without a login', type: :feature do

  scenario 'Visit Home Page - NOT logged in - rediected to login' do
    visit home_path
    expect(page).to  have_http_status(:success)
    expect(current_path).to eq(new_user_session_path)
  end

  describe "GET /home - logged in" do
    let(:user)  { FactoryBot.create :user }
    before do
      sign_in user
    end
    after do
      sign_out user
    end

    scenario 'Visit home Page' do
      visit home_path
      expect(page).to  have_http_status(:success)
      expect(current_path).to eq(home_path)
      page_tag = find('p#home_index', text: 'Home Index', visible: false)
      expect(page_tag).to be_truthy
    end
  end

end
