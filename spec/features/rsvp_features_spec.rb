require 'rails_helper'

RSpec.feature "RsvpFeatures", type: :feature do
  context 'RSVPing' do
    Steps 'to add or cancel an rsvp to an event' do
      Given "I have created an event and am on the show page" do
        visit "/"

        click_on "Sign Up"
        fill_in "Email", with: "mrin@mrin.m"
        fill_in "Password", with: "mrinsin"
        fill_in "Password confirmation", with: "mrinsin"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
        click_on "Sign up"

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

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Create Event"

        expect(page).to have_content "Event was successfully created"
        expect(page).to have_content "Mating Season"
      end

      When "I click yes to RSVP" do
        click_on "Count Me In"
      end

      #Updated to test for list of attendees on Event page
      Then "I have RSVPd to the event" do
        expect(page).to have_content "RSVP was successfully created."
        expect(page).to have_content "1 attendee"
        expect(page).to have_content "firstname lastname"
      end

      When "I cancel my RSVP" do
        click_on "Cancel RSVP"
      end

      Then "I am no longer RSVPd to the event" do
        expect(page).to have_content "RSVP was successfully destroyed."
        expect(page).to have_content "0 attendees"
        expect(page).not_to have_content "firstname lastname"
      end







    end #end of steps
  end # end of context
end #end of rspec
