require 'rails_helper'

# THIS FEATURE HAS BEEN DISABLED, WAITING TO MERGE FUNCTIONALITY WITH COMMENTS

RSpec.feature "CreatingEventReviews", type: :feature do
  # context "Adding reviews to an event" do
  #   Steps "to add an event review" do
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
  #     Then "I can add a new event" do
  #       visit "/events"
  #       click_on "New Event"
  #       fill_in "Name", with: "Mating Season"
  #       select "Mars", from: "Venue"
  #       click_on "Submit Event"
  #     end
  #
  #     And "I can see the event I just created" do
  #       expect(page).to have_content "Event was successfully created"
  #       expect(page).to have_content "Mating Season"
  #     end
  #
  #     Then "I can review the event" do
  #       fill_in "event_review[review]", with: "Josh just yawned again"
  #       click_on "Review!"
  #       expect(page).to have_content("Josh just yawned again")
  #     end
  #
  #   end # end steps
  # end #end context
end # end rspec
