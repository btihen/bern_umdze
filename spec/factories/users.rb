FactoryBot.define do
  factory :user do
    email     { "user@test.ch" }
    password  { "Let-Me-In!" }
    password_confirmation  { password }
  end
end
