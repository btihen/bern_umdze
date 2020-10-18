FactoryBot.define do
  factory :user do
    sequence(:username)   { |n| "user_#{n}" }
    real_name             { "#{username} name" }
    access_role           { "viewer" }
    email                 { "#{username}@test.ch" }
    password              { "Let-M3-In-N0w" }
    password_confirmation { password }
  end
end
