require 'rails_helper'

RSpec.describe "managers/users/edit", type: :view do
  before(:each) do
    @managers_user = assign(:managers_user, Managers::User.create!())
  end

  it "renders the edit managers_user form" do
    render

    assert_select "form[action=?][method=?]", managers_user_path(@managers_user), "post" do
    end
  end
end
