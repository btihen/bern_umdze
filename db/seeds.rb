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
user  = User.create(email: "user@test.com",
                    password: "Let-M3-In-N0w",
                    password_confirmation: "Let-M3-In-N0w")