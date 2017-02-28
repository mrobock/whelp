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
        # user1 = User.new(email: "mrin@mrin.m", password: "mrinsin", password_confirmation: "mrinsin", first_name: "firstname", last_name: "lastname")
        # user1.save
        # user2 = User.find_by_first_name("firstname")

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


      And "I can see the average and current count of rating(s) on the venue's page." do
        Rating.create(rating: 4, user: User.first, venue: Venue.first)
        visit "/venues/#{Venue.find_by_name('Mars Attacks').id}"
        expect(page).to have_content('Average Rating:')
        # Note: js: true breaks many tests, so since average rating values and the number of ratings is based on JS, we have to figure out how to configure these tests later
      end

      And 'I can see the average and current count of rating(s) in the venue index page' do
        visit '/venues'
        expect(page).to have_content('Avg Rating: 4.00')
        expect(page).to have_content('1 Rating')
      end

      When 'Another user adds another rating to that venue' do
        click_on "Sign Out"
        click_on "Sign Up"
        fill_in "Username", with: "blahblah"
        fill_in "Email", with: "eric@mrin.m"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        fill_in "First name", with: "first"
        fill_in "Last name", with: "lastname"
        click_on "Sign up"

        Rating.create(rating: 1, user: User.find_by_first_name("first"), venue: Venue.first)
        visit "/venues/#{Venue.find_by_name('Mars Attacks').id}"
        expect(page).to have_content('Average Rating:')
        #ibid line 42
      end

      Then 'I can see the new average and count of rating(s) in the venue index page' do
        visit '/venues'
        expect(page).to have_content('Avg Rating: 2.50')
        expect(page).to have_content('2 Ratings')
      end

      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Submit Event"
        expect(page).to have_content("Event was successfully created")
      end

      And "I can see a rating on the event's page." do
        Rating.create(rating: 3, user: User.first, event: Event.first)
        visit "/events/#{Event.find_by_name('Mating Season').id}"
        expect(page).to have_content('Average Rating:')
        # ibid line 42
      end

    end
  end
end
