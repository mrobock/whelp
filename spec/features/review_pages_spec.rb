require 'rails_helper'

# THIS FEATURE HAS BEEN DISABLED, WAITING TO MERGE FUNCTIONALITY WITH COMMENTS

RSpec.feature "ReviewPages", type: :feature do
# context "Able to create reviews for events and venues" do
#   Steps "creating a user, venue, event and reviews" do
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
#       click_on "Submit Event"
#       expect(page).to have_content("Venue was successfully created")
#     end
#
#     And "I can add a review to the venue" do
#       click_on "Back"
#       click_on "Show"
#       expect(page).to have_content("Reviews")
#       fill_in "venue_review", with: "Mars ATTACKED!"
#       click_on "Review!"
#       expect(page).to have_content("Venue review was successfully created")
#       expect(page).to have_content("Mars ATTACKED!")
#     end
#
#     Then "I can add a new event" do
#       visit "/events"
#       click_on "New Event"
#       fill_in "Name", with: "Mating Season"
#       select "Mars", from: "Venue"
#       click_on "Submit Event"
#       expect(page).to have_content("Event was successfully created")
#     end
#
#     And "I can add a review to the event" do
#       click_on "Back"
#       click_on "Show"
#       expect(page).to have_content("Reviews")
#       fill_in "event_review", with: "Mating Season ATTACKED!"
#       click_on "Review!"
#       expect(page).to have_content("Event review was successfully created")
#       expect(page).to have_content("Mating Season ATTACKED!")
#     end
#     end
#   end
end
