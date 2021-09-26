FactoryBot.define do
  factory :reservation do
    event           { FactoryBot.create :event }
    space           { FactoryBot.create :space }
    remote_link     { [Faker::Internet.url, Faker::Internet.url, Faker::Internet.url, nil].sample }
    repeat_booking  { nil }

    # simplifies input
    start_date      { Date.today }
    end_date        { Date.today }
    start_time      { Time.now - 1.hour }
    end_time        { Time.now + 1.hour }

    host_name       { nil }
    alert_notice    { nil }

    # simplifies sorting (build in model)
    start_date_time { nil }
    end_date_time   { nil }
    is_cancelled    { false }

  end
end
