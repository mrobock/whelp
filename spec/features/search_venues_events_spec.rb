require 'rails_helper'

RSpec.feature "SearchVenuesEvents", type: :feature do
  context 'I am searching Venues and Events' do
    Steps "Searching for a venue and event" do
      Given "I am on the landing page" do
        visit "/"
      end
      And 'I have set up a User and two Venues with the word "dog" in the object, and one without "dog"' do
        click_on "Sign Up"
        fill_in "Email", with: "mrin@mrin.m"
        fill_in "Password", with: "mrinsin"
        fill_in "Password confirmation", with: "mrinsin"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
        click_on "Sign up"

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
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")

        visit "/venues"
        click_on "New Venue"
        fill_in "Name", with: "Dog time"
        fill_in "Description", with: "Mars Attacks again part 2"
        fill_in "Street 1", with: "Mars"
        fill_in "City", with: "Mars"
        fill_in "State", with: "Mars"
        fill_in "Zip", with: "Mars"
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")

        visit "/venues"
        click_on "New Venue"
        fill_in "Name", with: "Mars Attacks 2"
        fill_in "Description", with: "Mars Attacks again with a dog!"
        fill_in "Street 1", with: "Mars"
        fill_in "City", with: "Mars"
        fill_in "State", with: "Mars"
        fill_in "Zip", with: "Mars"
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      And 'I have created two events with the word "dog" somewhere in the object, and one without "dog"' do

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars Attacks", from: "Venue"
        click_on "Create Event"

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Dog Days"
        select "Mars Attacks", from: "Venue"
        click_on "Create Event"

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Other Mating Season"
        fill_in "Description", with: "Dog mating season time on Mars"
        select "Mars Attacks", from: "Venue"
        click_on "Create Event"

        expect(page).to have_content "Event was successfully created"
        expect(page).to have_content "Mating Season"
      end

      When "I visit the homepage, and I'm logged in" do
        visit '/'
      end
      And 'I type in "dog" and click "Search"' do
        fill_in "search_params", with: 'dog'
        click_on 'Search'
      end
      Then 'I should see four entries that contain dog somewhere in the object' do
        expect(page).to have_content("Dog time")
        expect(page).to have_content("Mars Attacks 2")
        expect(page).to have_content("Dog Days")
        expect(page).to have_content("Other Mating Season")
      end

      When 'I type in "cat" and click "Search"' do
        fill_in "search_params", with: 'cat'
        click_on 'Search'
      end
      Then 'I should see no entries, and get a message showing there are no matches for my search' do
        expect(page).to have_content("No results match your search!")
      end

      When "I search and there are no non-whitespace characters" do
        click_on 'Search'
      end
      Then "An alert should pop up, telling you to type something in the search bar" do
        expect(page).to have_content("You must type something in the search bar.")
      end

      When 'I log out and I search the word "dog"' do
        click_on 'Sign Out'
        fill_in "search_params", with: 'dog'
        click_on 'Search'
      end
      Then 'I should still be able to see four entries that contain dog somewhere in the object' do
        expect(page).to have_content("Dog time")
        expect(page).to have_content("Mars Attacks 2")
        expect(page).to have_content("Dog Days")
        expect(page).to have_content("Other Mating Season")
      end
    end
  end
end
