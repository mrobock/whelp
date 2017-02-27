require 'rails_helper'

RSpec.feature "UpcomingEvents", type: :feature do
  context 'Adding future events and seeing them on the homepage' do
    Steps "creating a user, venue and event" do
      Given "I am on the landing page" do
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
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Submit Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      Then "I can add a new future event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Future Event 1"
        select "December", from: "event[date(2i)]"
        select "31", from: "event[date(3i)]"
        select "2017", from: "event[date(1i)]"
        select "11 PM", from: "event[date(4i)]"
        select "45", from: "event[date(5i)]"
        select "Mars", from: "Venue"
        click_on "Submit Event"
      end

      And "I can add a second new future event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Future Event 2"
        select "December", from: "event[date(2i)]"
        select "31", from: "event[date(3i)]"
        select "2020", from: "event[date(1i)]"
        select "11 PM", from: "event[date(4i)]"
        select "45", from: "event[date(5i)]"
        select "Mars", from: "Venue"
        click_on "Submit Event"
      end

      And "I can add a third new future event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Future Event 3"
        select "December", from: "event[date(2i)]"
        select "31", from: "event[date(3i)]"
        select "2022", from: "event[date(1i)]"
        select "11 PM", from: "event[date(4i)]"
        select "45", from: "event[date(5i)]"
        select "Mars", from: "Venue"
        click_on "Submit Event"
      end

      Then "I can see all three upcoming events on the homepage" do
        visit "/"
        expect(page).to have_content "Future Event 1"
        expect(page).to have_content "Future Event 2"
        expect(page).to have_content "Future Event 3"
      end
    end
  end # end of context
end
