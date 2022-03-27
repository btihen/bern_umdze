# frozen_string_literal: true

FactoryBot.define do
  factory :attend do
    location { 'MyString' }
    participant { nil }
    reservation { nil }
  end
end
