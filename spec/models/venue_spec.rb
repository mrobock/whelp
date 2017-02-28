require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe "Venue" do
    it "has to be real" do
      expect{Venue.new}.to_not raise_error
    end

    it "can create and save a new venue" do
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
      user1.save
      venue.user = user1
      expect{venue.save}.to_not raise_error
    end

    it "can read a current venue in the database" do
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
      user1.save
      venue.user = user1
      expect{venue.save}.to_not raise_error

      venue1 = Venue.find_by_name("Venue name")
      expect(venue1.description).to eq("venue description")
      expect(venue1.street_1).to eq("123 venue ave")
      expect(venue1.street_2).to eq("unit 1")
      expect(venue1.city).to eq("san diego")
      expect(venue1.state).to eq("CA")
      expect(venue1.zip).to eq("92108")
      user2 = User.find_by_username("Joe1")
      expect(user2.email).to eq("joe@home.com")
    end

    it "can modify a current venue in the database" do
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
      user1.save
      venue.user = user1
      expect{venue.save}.to_not raise_error

      venue1 = Venue.find_by_name("Venue name")
      venue1.description = "venue update description"
      venue1.save

      venue2 = Venue.find_by_name("Venue name")
      expect(venue1.description).to eq("venue update description")
    end

    it "can delete a current venue in the database" do
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
      user1.save
      venue.user = user1
      expect{venue.save}.to_not raise_error

      venue1 = Venue.find_by_name("Venue name")
      expect{venue1.destroy}.to_not raise_error

      expect(Venue.find_by_name("Venue name")).to be(nil)
    end

    it "can deactivate a current venue in the database" do
      venue = Venue.new
      venue.name = "Venue name"
      venue.description = "venue description"
      venue.street_1 = "123 venue ave"
      venue.street_2 = "unit 1"
      venue.city = "san diego"
      venue.state = "CA"
      venue.zip = "92108"
      user1 = User.new(username: "Joe1", email: "joe@home.com", password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
      user1.save
      venue.user = user1
      venue.save

      venue = Venue.find_by_name("Venue name")
      expect(venue.active?).to eq true

      venue.soft_delete
      venue.save

      venue = Venue.find_by_name("Venue name")
      expect(venue.active?).to eq false
    end
  end
end
