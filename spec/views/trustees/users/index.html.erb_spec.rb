require 'rails_helper'

RSpec.describe "trustees/users/index", type: :view do
  before(:each) do
    assign(:trustees_users, [
      Trustees::User.create!(),
      Trustees::User.create!()
    ])
  end

  it "renders a list of trustees/users" do
    render
  end
end
