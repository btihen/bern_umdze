FactoryBot.define do
  factory :participant do
    sequence(:fullname)     { |n| "Participant Name#{n}" }
    sequence(:email)        { |n| "participant_#{n}@test.ch" }
    sequence(:login_token)  { |n| "Secr3t-T0ken-#{n}" }
    token_valid_until       { DateTime.now + 15.minutes } # must login withing 15 Mins
    ip_addr                 { Faker::Internet.public_ip_v4_address }  # "24.29.18.175"
  end
end
