require 'rails_helper'

RSpec.describe 'Landing Page Features without a login', type: :feature do
  scenario 'Visit landing Page' do
    visit root_path
    
    page_tag = find('p#landing_index', text: 'Landing Index', visible: false)
    expect(page_tag).to be_truthy
  end
end