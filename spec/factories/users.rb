FactoryBot.define do
  factory :user do
    username  { "user" }
    access_role { nil }
    email     { "user@test.ch" }
    password  { "Let-M3-In-N0w" }
    password_confirmation  { password }
  end
end
