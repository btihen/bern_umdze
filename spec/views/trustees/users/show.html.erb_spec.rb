require 'rails_helper'

RSpec.describe "trustees/users/show", type: :view do
  before(:each) do
    @trustees_user = assign(:trustees_user, Trustees::User.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
