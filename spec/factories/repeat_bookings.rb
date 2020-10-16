FactoryBot.define do
  factory :repeat_booking do

    # relationships
    event             { FactoryBot.create :event, event_name: "Werma" }
    space             { FactoryBot.create :space, space_name: "Zentrum" }

    # simplifies input
    start_date        { Date.new(2021, 1, 2) }
    end_date          { Date.new(2021, 1, 3) }
    start_time        { Time.parse("09:30", start_date) }
    end_time          { Time.parse("18:30", end_date) }

    host_name         { "Marianne" }
    alert_notice      { nil }

    # simplifies sorting (build in model)
    start_date_time   { nil }
    end_date_time     { nil }
    is_cancelled      { false }

    # infos needed to create many different repeat bookings
    repeat_every      { 2 }  # every 1 month (every 2 months), etc.
    repeat_unit       { "month" }  # year, month, week, day
    repeat_ordinal    { "first" }  # first, second, third, fourth, fifth, last, this (date)
    repeat_choice     { "sat" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    repeat_until_date { start_date + 1.year }  # repeat until one year from today (or date chosen)

    # first   - jan 2-3, 2021
    # second  - mar 6-7, 2021
    # third   - may 1-2, 2021
    # fourth  - jul 3-4, 2021
    # fifth   - sep 4-5, 2021
    # sixth   - nov 6-7, 2021
    # seventh - jan 1-2, 2022

  end
end
