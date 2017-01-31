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
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "December", from: "event[date(2i)]"
        select "31", from: "event[date(3i)]"
        select "2022", from: "event[date(1i)]"
        select "11 PM", from: "event[date(4i)]"
        select "59", from: "event[date(5i)]"
        select "Mars", from: "Venue"
        click_on "Create Event"
      end

      And "I can see the event I just created" do
        expect(page).to have_content "Event was successfully created"
        expect(page).to have_content "Mating Season"
        expect(page).to have_content "12/31/2022 at 11:59 PM"
      end

      When 'I click "Edit"' do
        click_on 'Edit'
      end
      And 'I attach an image file and click "Update Event"' do
        attach_file('event[image]', 'spec/images/foo.jpg')
        click_on "Update Event"
      end
      Then 'I can see the picture' do
        expect(page).to have_css('img')
      end
    end
  end # end of context
end #end of rspec
