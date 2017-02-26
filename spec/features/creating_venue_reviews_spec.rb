require 'rails_helper'

# THIS FEATURE HAS BEEN DISABLED, WAITING TO MERGE FUNCTIONALITY WITH COMMENTS

RSpec.feature "CreatingVenueReviews", type: :feature do
  # context "Adding reviews for venue" do
  #   Steps "creating a user, venue, and reviewing venue" do
  #     Given "I am on the landing page" do
  #       visit "/"
  #     end
  #     Then "I can sign up and log in as a user" do
  #       click_on "Sign Up"
  #       fill_in "Email", with: "mrin@mrin.m"
  #       fill_in "Password", with: "mrinsin"
  #       fill_in "Password confirmation", with: "mrinsin"
  #       fill_in "First name", with: "firstname"
  #       fill_in "Last name", with: "lastname"
  #       click_on "Sign up"
  #     end
  #
  #     Then "I can create a new venue" do
  #       user1 = User.new(email: "mrin@mrin.m", password: "mrinsin", password_confirmation: "mrinsin", first_name: "firstname", last_name: "lastname")
  #       user1.save
  #       user2 = User.find_by_first_name("firstname")
  #
  #       visit "/venues"
  #       click_on "New Venue"
  #       fill_in "Name", with: "Mars Attacks"
  #       fill_in "Description", with: "Mars Attacks again"
  #       fill_in "Street 1", with: "Mars"
  #       fill_in "City", with: "Mars"
  #       fill_in "State", with: "Mars"
  #       fill_in "Zip", with: "Mars"
  #       attach_file('venue[image]', 'spec/images/foo.jpg')
  #       click_on "Submit Event"
  #       expect(page).to have_content("Venue was successfully created")
  #     end
  #
  #     Then "I can create a review" do
  #       fill_in "venue_review[review]", with: "heck yay"
  #       click_on "Review!"
  #       expect(page).to have_content("Venue review was successfully created.")
  #     end
  #
  #   end
  # end
end
