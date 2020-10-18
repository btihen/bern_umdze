FactoryBot.define do
  factory :repeat_booking do

    # relationships
    event             { FactoryBot.create :event, event_name: "Werma" }
    space             { FactoryBot.create :space, space_name: "Zentrum" }

    # simplifies input
    start_date        { Date.new(2021, 1, 2) }
    end_date          { Date.new(2021, 1, 2) }
    start_time        { Time.parse("09:30") }
    end_time          { Time.parse("18:30") }

    host_name         { "Marianne" }
    alert_notice      { nil }

    # simplifies sorting (build in model)
    start_date_time   { nil }
    end_date_time     { nil }
    is_cancelled      { false }

    # infos needed to create many different repeat bookings
    repeat_every      { 1 }  # every 1 month (every 2 months), etc.
    repeat_unit       { "month" }  # year, month, week, day
    repeat_ordinal    { "first" }  # first, second, third, fourth, fifth, last, this (date)
    repeat_choice     { "sat" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    repeat_until_date { start_date + 1.year }  # repeat until one year from today (or date chosen)

    trait :first_mon_each_year do
      repeat_every      { 1 }
      repeat_unit       { "year" }  # year, month, week, day
      repeat_ordinal    { "first" }  # first, second, third, fourth, fifth, last, this (date)
      repeat_choice     { "mon" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    end

    trait :same_date_each_year do
      repeat_every      { 1 }
      repeat_unit       { "year" }  # year, month, week, day
      repeat_ordinal    { "this" }  # first, second, third, fourth, #fifth, #last, this (date)
      repeat_choice     { "date" }  # mon, tue, wed, thu, fri, sat, sun, #day, date (this reservation date of month / year)
    end

    trait :same_date_every_2_months do
      repeat_every      { 2 }
      repeat_unit       { "month" }  # year, month, week, day
      repeat_ordinal    { "this" }  # first, second, third, fourth, #fifth, #last, this (date)
      repeat_choice     { "date" }  # mon, tue, wed, thu, fri, sat, sun, #day, date (this reservation date of month / year)
    end

    trait :second_wed_every_3_months do
      repeat_every      { 3 }
      repeat_unit       { "month" }  # year, month, week, day
      repeat_ordinal    { "second" }  # first, second, third, fourth, fifth, last, this (date)
      repeat_choice     { "wed" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    end

    trait :fri_every_3_weeks do
      repeat_every      { 3 }
      repeat_unit       { "week" }  # year, month, week, day
      repeat_ordinal    { "" }  # first, second, third, fourth, fifth, last, this (date)
      repeat_choice     { "fri" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    end

    trait :every_4_days do
      repeat_every      { 4 }
      repeat_unit       { "day" }  # year, month, week, day
      repeat_ordinal    { "" }  # first, second, third, fourth, fifth, last, this (date)
      repeat_choice     { "" }  # mon, tue, wed, thu, fri, sat, sun, day, date (this reservation date of month / year)
    end

  end

end
