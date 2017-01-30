require 'rails_helper'

RSpec.describe Rating, type: :model do
  it "must exist" do
    expect{Rating.new}.to_not raise_error
  end
  it "must not be able to be saved without a user id and a rating" do
    rating = Rating.new
    expect(rating.save).to eq false
    user = User.create(username: "dummy1", email: "dummy@home.com", password: "password1", password_confirmation: "password1", first_name: "firstname", last_name: "lastname")
    rating.user = user
    rating.rating = "4"
    expect(rating.save).to eq true
  end
  it "must be able to take either an event or a venue id in addition to the user id" do
    user = User.create(username: "dummy1", email: "dummy@home.com", password: "password1", password_confirmation: "password1", first_name: "firstname", last_name: "lastname")
    venue = Venue.create(name: "Josh Mrin", description: "amazing awesome fubn cool", user: user)

    event = Event.create(name: "first event", description: "this will be an awesome party", date: "01/02/2018", venue: venue, user: user)

    rating_1 = Rating.new(user: user, event: event, rating: "3")
    expect(rating_1.save).to eq true

    rating_2 = Rating.new(user: user, venue: venue, rating:"1")
    expect(rating_2.save).to eq true
  end
  # it "must not be saveable without either a venue id or an event id"
end
