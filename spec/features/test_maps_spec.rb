require 'rails_helper'

RSpec.feature "TestMaps", type: :feature do
  context 'A Map was added to the show and index page.' do
    Steps "I created a user, venue and event" do
      Given "and I am on the landing page" do
        visit "/"
      end
      Then "I can sign up and log in as a user" do
        click_on "Sign Up"
        fill_in "Email", with: "mrin@mrin.m"
        fill_in "Password", with: "mrinsin"
        fill_in "Password confirmation", with: "mrinsin"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
        click_on "Sign up"
      end
      Then "I can create a new venue" do
        user1 = User.new(email: "mrin@mrin.m", password: "mrinsin", password_confirmation: "mrinsin", first_name: "firstname", last_name: "lastname")
        user1.save
        user2 = User.find_by_first_name("firstname")

        visit "/venues"
        click_on "New Venue"
        fill_in "Name", with: "Mars Attacks"
        fill_in "Description", with: "Mars Attacks again"
        fill_in "Street 1", with: "Mars"
        fill_in "City", with: "Mars"
        fill_in "State", with: "Mars"
        fill_in "Zip", with: "Mars"
        click_on "Submit Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      And 'I can go to the map locations JSON page' do
        visit "/venues/#{Venue.first.id}/map_location.json"
      end

      And 'I will see the JSON object includes a lat and long' do
        expect(page).to have_content "#{Venue.first.latitude}"
      end

      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Submit Event"
        expect(page).to have_content("Event was successfully created")
      end
#so extra because we cannot have two map_location
      Then 'I can go to the map locations JSON page' do
       visit "/venues/#{Event.first.venue.id}/map_location.json"
      end

      And 'I will see the JSON object includes a lat and long' do
       expect(page).to have_content "#{Event.first.venue.latitude}"
      end
    end
  end
end
