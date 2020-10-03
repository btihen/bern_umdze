FactoryBot.define do
  factory :event do
    event_name { Faker::Educator.subject }
  end
end
