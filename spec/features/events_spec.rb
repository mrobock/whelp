require 'rails_helper'

RSpec.feature "Events", type: :feature do
  context 'Adding a new event' do
    Steps "creating a user, venue and event" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can sign up and log in as a user" do
        click_on "Sign Up"
        fill_in "Email", with: "mrin@mrin.m"
        fill_in "Password", with: "mrinsin"
        fill_in "Password confirmation", with: "mrinsin"
        click_on "Sign up"
      end

      Then "I can create a new venue" do
        user1 = User.new(email: "mrin@mrin.m", password: "mrinsin", password_confirmation: "mrinsin")
        user1.save
        user2 = User.find_by_email("mrin@mrin.m")
        
        visit "/venues"
        click_on "New Venue"
        fill_in "Name", with: "Mars"
        fill_in "Description", with: "Mars"
        fill_in "Street 1", with: "Mars"
        fill_in "City", with: "Mars"
        fill_in "State", with: "Mars"
        fill_in "Zip", with: "Mars"
        fill_in "User", with: user2.id
        click_on "Create Venue"
      end

      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Create Event"
      end

      And "I can see the event I just created" do
        expect(page).to have_content "Event was successfully created"
        expect(page).to have_content "Mating Season"
      end

    end
  end # enf of context
end #end of rspec
