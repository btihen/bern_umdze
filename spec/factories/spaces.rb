# frozen_string_literal: true

FactoryBot.define do
  factory :space do
    sequence(:space_name) { |n| "#{Faker::Educator.campus} #{n}" }
  end
end
