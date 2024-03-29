# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:event_name) { |n| "#{Faker::Educator.subject} #{n}" }
  end
end
