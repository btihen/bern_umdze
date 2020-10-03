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
                      access_role: nil,
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
