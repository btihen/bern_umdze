require 'rails_helper'

RSpec.describe "trustees/users/new", type: :view do
  before(:each) do
    assign(:trustees_user, Trustees::User.new())
  end

  it "renders new trustees_user form" do
    render

    assert_select "form[action=?][method=?]", trustees_users_path, "post" do
    end
  end
end
