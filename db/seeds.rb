# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# test with:
# user = User.first
# user.valid_password? "xxxx"
user    = User.create(email: "user@test.ch",
                      username: "user",
                      password: "Let-M3-In!",
                      password_confirmation: "Let-M3-In!")
member  = User.create(email: "member@test.ch",
                      username: "member",
                      access_role: 'member',
                      password: "Let-M3-In!",
                      password_confirmation: "Let-M3-In!")
umdze   = User.create(email: "umdze@test.ch",
                      username: "umdze",
                      access_role: 'umdze',
                      password: "Let-M3-In!",
                      password_confirmation: "Let-M3-In!")
trustee = User.create(email: "trustee@test.ch",
                      username: "trustee",
                      access_role: 'trustee',
                      password: "Let-M3-In!",
                      password_confirmation: "Let-M3-In!")

spaces = []
spaces << Space.create(space_name: "Zentrum")
# spaces << FactoryBot.create(:space, space_name: "Anex")

# events = []
# 5.times do
#   event   = FactoryBot.create :event
#   events << event
# end
events = 5.times.map { FactoryBot.create :event }

hour_am_start = Time.parse('09:30')
hour_am_end   = Time.parse('12:30')
hour_pm_start = Time.parse('13:30')
hour_pm_end   = Time.parse('17:30')
hour_ev_start = Time.parse('18:30')
hour_ev_end   = Time.parse('20:30')

(-4..4).each do |shift|
  # a range a dates before and after
  date_0  = Date.today + (shift*2).weeks
  date_1  = date_0 + 1.day
  date_2  = date_0 + 2.days
  date_3  = date_0 + 3.days
  date_4  = date_0 + 4.days
  date_5  = date_0 + 5.days

  # schedule events within spaces
  spaces.each do |space|
    FactoryBot.create(:reservation, space: space, event: events.first,  start_date: date_0, start_time: hour_ev_start, end_date: date_2, end_time: hour_pm_end, host_name: [nil, User.all.map(&:username)].flatten.sample, is_cancelled: [0,1,2,3,4,5,6,7,8,9].sample == 1)
    FactoryBot.create(:reservation, space: space, event: events.second, start_date: date_3, start_time: hour_am_start, end_date: date_3, end_time: hour_am_end, host_name: [nil, User.all.map(&:username)].flatten.sample, is_cancelled: [0,1,2,3,4,5,6,7,8,9].sample == 3)
    FactoryBot.create(:reservation, space: space, event: events.last,   start_date: date_3, start_time: hour_ev_start, end_date: date_3, end_time: hour_ev_end, host_name: [nil, User.all.map(&:username)].flatten.sample, is_cancelled: [0,1,2,3,4,5,6,7,8,9].sample == 5)
    FactoryBot.create(:reservation, space: space, event: events.sample, start_date: date_5, start_time: hour_pm_start, end_date: date_5, end_time: hour_ev_end, host_name: [nil, User.all.map(&:username)].flatten.sample, is_cancelled: [0,1,2,3,4,5,6,7,8,9].sample == 7)
    # space.save
  end
end
