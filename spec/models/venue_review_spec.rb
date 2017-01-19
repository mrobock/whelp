require 'rails_helper'

RSpec.describe VenueReview, type: :model do



  it "should exist" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save
    venue_review = VenueReview.new(review: "nice job")
    venue_review.venue = venue
    venue_review.user = user1

    expect{venue_review}.to_not raise_error
    expect(venue_review.save).to be true

  end

  it "should have a review" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save
    venue_review = VenueReview.new(review: "nice job")
    venue_review.venue = venue
    venue_review.user = user1
    venue_review.save

    review = VenueReview.find(venue_review.id)

    expect(review.review).to be_a String
    expect(review.review).to eq "nice job"

  end

  it "should belong to a user" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save
    venue_review = VenueReview.new(review: "nice job")
    venue_review.venue = venue
    venue_review.user = user1
    venue_review.save
    review = VenueReview.find(venue_review.id)

    expect(review.user.username).to eq "mrin"

  end

  it "should belong to a venue" do
    user1 = User.new(username: "mrin", email: 'mrin@mrin.com', password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
    user1.save
    venue = Venue.new(name: "Josh Mrin", description: "amazing awesome fubn cool")
    venue.user = user1
    venue.save
    venue_review = VenueReview.new(review: "nice job")
    venue_review.venue = venue
    venue_review.user = user1
    venue_review.save
    review = VenueReview.find(venue_review.id)

    expect(review.venue.name).to eq "Josh Mrin"
  end
end
