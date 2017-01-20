require 'rails_helper'

RSpec.describe EventReview, type: :model do
  it "should exist" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"
    event.save

    review = EventReview.new(review: "Josh is yawning")
    review.user = user1
    review.event = event

    expect{review}.to_not raise_error
    expect(review.save).to be true

  end

  it "should have a review" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"
    event.save

    review = EventReview.new(review: "Josh is yawning")
    review.user = user1
    review.event = event
    review.save

    second_review = EventReview.find(review.id)

    expect(second_review.review).to eq "Josh is yawning"

  end

  it "should belong to a user and a venue" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue
    event.user_id = user1.id
    event.description = "this will be an awesome party"
    event.save

    review = EventReview.new(review: "Josh is yawning")
    review.user = user1
    review.event = event
    review.save
    second_review = EventReview.find(review.id)

    expect(second_review.user.username).to eq "mrin"
    expect(second_review.event.name).to eq "first event"

  end

end
