require 'rails_helper'

RSpec.describe "managers/users/new", type: :view do
  before(:each) do
    assign(:managers_user, Managers::User.new())
  end

  it "renders new managers_user form" do
    render

    assert_select "form[action=?][method=?]", managers_users_path, "post" do
    end
  end
end
