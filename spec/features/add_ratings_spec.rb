require 'rails_helper'


RSpec.feature "AddRatings", type: :feature do
  context 'Ratings were added to the venue and events show pages.' do
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
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")
      end


      And "I can see the average and current count of rating(s) on the venue's page." do
        Rating.create(rating: 4, user: User.first, venue: Venue.first)
        visit "/venues/#{Venue.find_by_name('Mars Attacks').id}"
        expect(page).to have_content('Average Rating:')
        expect(page).to have_content('Rating(s)')
      end


      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Create Event"
        expect(page).to have_content("Event was successfully created")
      end

      And "I can see a rating on the event's page." do
        Rating.create(rating: 3, user: User.first, event: Event.first)
        visit "/events/#{Event.find_by_name('Mating Season').id}"
        expect(page).to have_content('Average Rating:')
        expect(page).to have_content('Rating(s)')
      end

    end
  end
end
