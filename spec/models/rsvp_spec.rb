require 'rails_helper'

RSpec.describe Rsvp, type: :model do
  it 'must exist' do
    expect{Rsvp.new}.to_not raise_error
  end
  it 'should belong to a user and an event, and have a status' do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"

    rsvp = Rsvp.new
    rsvp.event = event
    rsvp.user = user1
    rsvp.status = "Yes"

    expect(rsvp.save).to eq true

    new_rsvp = Rsvp.find(rsvp.id)

    expect(new_rsvp.user.username).to eq "mrin"
    expect(new_rsvp.event.description).to eq "this will be an awesome party"
    expect(new_rsvp.status).to eq "Yes"   
  end
end
