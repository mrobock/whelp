require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "must exist" do
    expect{Comment.new}.to_not raise_error
  end

  it "can be created with a venue id" do
    expect{Venue.new}.to_not raise_error
    venue = Venue.new
    venue.name = "Venue name"
    venue.description = "venue description"
    venue.street_1 = "123 venue ave"
    venue.street_2 = "unit 1"
    venue.city = "san diego"
    venue.state = "CA"
    venue.zip = "92108"
    user1 = User.new(username: "Joe1", email: "joe@home.com", password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    expect(user1.save).to eq true
    venue.user = user1
    expect(venue.save).to eq true

    comment = Comment.new(title: "Example Comment", text:"Things are happening at this thing", user_id: user1.id, venue_id: venue.id)
    expect(comment.save).to eq true
  end

  it "can be created with an event id" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool", user_id: user1.id)
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018", description: "this will be an awesome party", venue_id: venue.id, user_id: user1.id)
    expect(event.save).to eq true

    comment = Comment.new(title: "Example Comment", text:"Things are happening at this thing", user_id: user1.id, event_id: event.id)
    expect(comment.save).to eq true
  end

  it "can not be created without a user" do
    comment = Comment.new(title: "Example Comment", text:"Things are happening at this thing")
    expect(comment.save).to eq false
  end
end
