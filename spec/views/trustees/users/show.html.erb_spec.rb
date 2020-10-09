require 'rails_helper'

RSpec.describe "managers/users/show", type: :view do
  before(:each) do
    @managers_user = assign(:managers_user, Managers::User.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
