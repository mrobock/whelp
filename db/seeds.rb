# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
  first_name: "Chris",
  last_name: "Fasulo",
  email: "chris@Fasulo.com",
  username: "cfasulo",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Fariya",
  last_name: "Vasquez",
  email: "fariya@vasquez.com",
  username: "fvasquez",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Joshua",
  last_name: "Fishman",
  email: "josh@fishman.com",
  username: "jfishman",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Eric",
  last_name: "Hendrickson",
  email: "eric@hendrickson.com",
  username: "ehendrickson",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Varun",
  last_name: "Kapila",
  email: "varun@kapila.com",
  username: "vkapila",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Max",
  last_name: "Robock",
  email: "max@robock.com",
  username: "mrobock",
  password: "password",
  password_confirmation: "password"
  },{
  first_name: "Mrinalini",
  last_name: "Sinha",
  email: "mrin@sinha.com",
  username: "msinha",
  password: "password",
  password_confirmation: "password"
  }])

Venue.create([{
  name: "LEARN",
  description: "Place in downtown",
  street_1: "704 J St",
  zip: "92101"
  },{
  name: "OLD LEARN",
  description: "LIKE OLD GREGG BUT OLDER",
  street_1: "1550 Market St",
  zip: "92101"
  },{
  name: "Thorn Brewery",
  description: "Located on Thorn Street!",
  street_1: "3176 Thorn St",
  zip: "92104"
  }])
