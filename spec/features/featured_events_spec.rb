require 'rails_helper'

RSpec.feature "FeaturedEvents", type: :feature do
  context 'Adding a new event' do
    Steps "creating a user, venue and event" do
      Given "I am on the landing page and I can see a Featured Events seciton" do
        visit "/"
        expect(page).to have_content("Featured Events")
      end

      Then "I can sign up and log in as a default user" do
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
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Submit Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      And "I can add four new events" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season 1"
        select "Mars Attacks", from: "Venue"
        click_on "Submit Event"

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season 2"
        select "Mars Attacks", from: "Venue"
        click_on "Submit Event"

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season 3"
        select "Mars Attacks", from: "Venue"
        click_on "Submit Event"

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season 4"
        select "Mars Attacks", from: "Venue"
        click_on "Submit Event"

        click_link "Sign Out"
      end

      Then "I can creat a user and give them an admin role" do
        visit "/"

        click_link "Sign Up"

        expect(page).to have_content("Sign up")
        fill_in 'user[username]', with: "admin"
        fill_in 'user[email]', with: "admin@test.com"
        fill_in 'user[password]', with: "password"
        fill_in 'user[password_confirmation]', with: "password"
        fill_in "First name", with: "admin"
        fill_in "Last name", with: "admin"
        attach_file('user[image]', 'spec/images/profile.jpeg')

        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")

        user = User.find_by(username: "admin")
        user.remove_role :default
        user.add_role :admin
        expect(user.has_role? :default).to eq false
        expect(user.has_role? :admin).to eq true
      end

      Then "I can make event 1 a featured event" do
        visit '/events'
        click_on "Mating Season 1"
        click_on "Make Featured"
        visit '/'
        expect(page).to have_content("Mating Season 1")
        expect(page).to have_content("Venue: Mars")
      end

      And "I can make event 2 a featured event" do
        visit '/events'
        click_on "Mating Season 2"
        click_on "Make Featured"
        visit '/'
        expect(page).to have_content("Mating Season 1")
        expect(page).to have_content("Venue: Mars")
      end

      And "I can make event 3 a featured event" do
        visit '/events'
        click_on "Mating Season 3"
        click_on "Make Featured"
        visit '/'
        expect(page).to have_content("Mating Season 1")
        expect(page).to have_content("Venue: Mars")
      end

      Then "I cannot make event 4 featured since there are only three featured events that will be shown" do
        visit '/events'
        click_on "Mating Season 4"
        click_on "Make Featured"
        expect(page).to have_content("Three (3) events are already featured, remove one before adding another.")
      end

      And "I can remove a featured event" do
        visit '/events'
        click_on "Mating Season 3"
        click_on "Remove Featured"
        visit '/'
        expect(page).not_to have_content("Mating Season 3")
      end
    end
  end
end
