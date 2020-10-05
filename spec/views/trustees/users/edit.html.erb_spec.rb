require 'rails_helper'

RSpec.describe "trustees/users/edit", type: :view do
  before(:each) do
    @trustees_user = assign(:trustees_user, Trustees::User.create!())
  end

  it "renders the edit trustees_user form" do
    render

    assert_select "form[action=?][method=?]", trustees_user_path(@trustees_user), "post" do
    end
  end
end
