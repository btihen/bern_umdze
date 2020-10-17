FactoryBot.define do
  factory :user do
    username      { "user" }
    real_name     { "real_name" }
    access_role   { "viewer" }
    email         { "user@test.ch" }
    password      { "Let-M3-In-N0w" }
    password_confirmation  { password }
  end
end
