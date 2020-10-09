require 'rails_helper'

RSpec.describe "managers/users/index", type: :view do
  before(:each) do
    assign(:managers_users, [
      Managers::User.create!(),
      Managers::User.create!()
    ])
  end

  it "renders a list of managers/users" do
    render
  end
end
