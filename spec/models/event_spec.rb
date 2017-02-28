require 'rails_helper'

RSpec.describe Event, type: :model do
   it 'should have name date venue' do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"

    expect(event.save).to eq true

    event2 = Event.find_by_name("first event")
    venue2 = Venue.find(event2.venue_id)
    expect(venue2.name).to eq "Josh Mrin"
    expect(event2.date).to eq "Thu, 01 Feb 2018 00:00:00 PST -08:00"
  end

  it 'should have a description and a user id' do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "second event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"

    expect(event.save).to eq true
    event2 = Event.find_by_name("second event")
    expect(event2.description).to eq "this will be an awesome party"
    expect(event2.user_id).to eq user1.id
  end

  it 'should be able to be deactivated' do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "second event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"

    event.save

    event = Event.find_by(name: "second event")
    expect(event.active?).to eq true

    event.soft_delete
    event.save

    event = Event.find_by(name: "second event")
    expect(event.active?).to eq false
  end
end
