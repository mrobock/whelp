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
        click_on "Submit Venue"
        expect(page).to have_content("Venue was successfully created")

        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select (DateTime.now.year+1), from: 'event_date_1i'
        select "Mars", from: "Venue"
        click_on "Submit Event"

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

    Steps 'try to add or cancel an rsvp to an event that has already started' do
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
        click_on "Submit Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      When 'I am on the page of an event that happened in the past' do
        event = Event.new
        event.name = "Something"
        event.venue = Venue.find_by(name: "Mars Attacks")
        event.user = User.find_by(email: "mrin@mrin.m")
        event.description = "Mars Attacks yet again"
        event.date = DateTime.now.change({ year: DateTime.now.year-1 })
        event.save

        visit '/events/' + event.id.to_s
      end

      Then "I cannot see a button to RSVP" do
        expect(page).to_not have_content("Count Me In")
      end

      And "I can see a message saying it's too late to RSVP" do
        expect(page).to have_content("Sorry, it's too late to RSVP to this event.")
      end

      When 'I am on the page of an event that happened in the past that I already RSVPd to' do
        event = Event.new
        event.name = "Something"
        event.venue = Venue.find_by(name: "Mars Attacks")
        event.user = User.find_by(email: "mrin@mrin.m")
        event.description = "Mars Attacks yet again"
        event.date = DateTime.now.change({ year: DateTime.now.year-1 })
        event.save

        rsvp = Rsvp.new
        rsvp.user_id = User.find_by(email: "mrin@mrin.m").id
        rsvp.event_id = event.id
        rsvp.save

        visit '/events/' + event.id.to_s
      end

      Then 'I cannot see a button to cancel my RSVP' do
        expect(page).to_not have_content("Cancel RSVP")
      end

      And 'I can see a blank button that tells me I have RSVPd' do
        expect(page).to have_content("RSVPd")
      end

      When "I am not logged in and I'm viewing an event that already happened" do
        event = Event.new
        event.name = "Something Else"
        event.venue = Venue.find_by(name: "Mars Attacks")
        event.user = User.find_by(email: "mrin@mrin.m")
        event.description = "Mars Attacks yet again"
        event.date = DateTime.now.change({ year: DateTime.now.year-1 })
        event.save

        click_on 'Sign Out'
        visit '/events/' + event.id.to_s
      end

      Then 'I should not see anything that allows me to RSVP or tells me to log in to RSVP' do
        expect(page).to_not have_content("Count Me In")
        expect(page).to_not have_content("Cancel RSVP")
        expect(page).to_not have_content("RSVPd")
        expect(page).to_not have_content("Sign in to RSVP!")
      end

    end #end of steps
  end # end of context
end #end of rspec
