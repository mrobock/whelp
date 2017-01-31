require 'rails_helper'

RSpec.feature "ManageUser", type: :feature do
  context "Acting as an admin" do
    Steps "Registering as an admin user and working with other users" do
      Given "I have created two default users" do
        visit "/"

        click_link "Sign Up"

        expect(page).to have_content("Sign up")
        fill_in 'user[username]', with: "test1"
        fill_in 'user[email]', with: "test1@test.com"
        fill_in 'user[password]', with: "password1"
        fill_in 'user[password_confirmation]', with: "password1"
        fill_in "First name", with: "test"
        fill_in "Last name", with: "one"

        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")

        click_on 'Sign Out'

        visit "/"

        click_link "Sign Up"

        expect(page).to have_content("Sign up")
        fill_in 'user[username]', with: "test2"
        fill_in 'user[email]', with: "test2@test.com"
        fill_in 'user[password]', with: "password2"
        fill_in 'user[password_confirmation]', with: "password2"
        fill_in "First name", with: "test"
        fill_in "Last name", with: "two"

        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")

        click_on 'Sign Out'
      end
      And "I have created a user and given them an admin role" do
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
      And "I am on the users list page and can see one default user's info" do
        visit '/users'
        expect(page).to have_content("test1")
      end
      Then "I should be able to edit that user's data by clicking 'Edit'" do
        find("a[href='/users/#{User.find_by(username: "test1").id}/edit']").click
      end
      And 'I should see and edit user form with the username and other data prefilled' do
        expect(page).to have_content("Edit")
      end
      When "I change the user's data" do
        fill_in 'user_email', with: "test3@test.com"
        fill_in "user_first_name", with: "Testy"
        fill_in "user_last_name", with: "McTestface"
      end
      And 'I click "Update"' do
        click_on 'Update'
      end
      Then 'I should see updated data for that user' do
        page.all("tr").each do |tr|
          next unless tr.has_selector?("test1")

          expect(page).to have_content("test1")
          expect(page).to have_content("Testy")
          expect(page).to have_content("McTestface")
          expect(page).to have_content("test3@test.com")
        end
      end
    end

    Steps "Registering as an admin user and working with Venues and Events" do
      Given "I have created default user" do
        visit "/"

        click_link "Sign Up"

        expect(page).to have_content("Sign up")
        fill_in 'user[username]', with: "test1"
        fill_in 'user[email]', with: "test1@test.com"
        fill_in 'user[password]', with: "password1"
        fill_in 'user[password_confirmation]', with: "password1"
        fill_in "First name", with: "test"
        fill_in "Last name", with: "one"

        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
      And 'I have created a venue' do
        visit '/venues'
        click_on 'Create New Venue'

        fill_in 'venue[name]', with: "Sample Venue"
        fill_in 'venue[description]', with: "Some description of this particular venue"

        click_on 'Create Venue'
      end
      And 'I have created an event' do
        visit '/events'
        click_on 'Create New Event'

        fill_in 'event[name]', with: "Sample Event"
        fill_in 'event[description]', with: "Some description of this particular event"

        click_on 'Create Event'
      end
      And "I have created a user and given them an admin role" do
        click_on 'Sign Out'
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

      When 'I navigate to the events page' do
        visit '/events'
      end
      Then 'I should see the event name that the default user made' do
        expect(page).to have_content("Sample Event")
      end
      And 'I should not see the "Create New Event" button' do
        expect(page).to_not have_content("Create New Event")
      end
      When 'I click on "Sample Event"' do
        click_on 'Sample Event'
      end
      Then 'I should not see anything allowing the user to RSVP' do
        expect(page).to_not have_content("My RSVP:")
        expect(page).to_not have_content("Count Me In")
        expect(page).to_not have_content("Cancel RSVP")
        expect(page).to_not have_content("Sign in to RSVP!")
      end
      When 'I click "Edit"' do
        click_on 'Edit'
      end
      And 'I change the title and update' do
        fill_in 'event[name]', with: "Example Event"
        click_on 'Update Event'
      end
      Then 'I should see the updated venue name' do
        expect(page).to have_content("Example Event")
      end
      When 'I click the "Destroy" link' do
        click_on 'Destroy'
      end
      Then "I should no longer see the event's data on the page" do
        expect(page).to_not have_content("Example Venue")
      end

      When 'I navigate to the venues page' do
        visit '/venues'
      end
      Then 'I should see the venue name that the default user made' do
        expect(page).to have_content("Sample Venue")
      end
      And 'I should not see the "Create New Venue" button' do
        expect(page).to_not have_content("Create New Venue")
      end
      When 'I click on "Sample Venue"' do
        click_on 'Sample Venue'
      end
      And 'I click "Edit"' do
        click_on 'Edit'
      end
      And 'I change the title and update' do
        fill_in 'venue[name]', with: "Example Venue"
        click_on 'Update Venue'
      end
      Then 'I should see the updated venue name' do
        expect(page).to have_content("Example Venue")
      end
      When 'I click the "Destroy" link' do
        click_on 'Destroy'
      end
      Then "I should no longer see the venue's data on the page" do
        expect(page).to_not have_content("Example Venue")
      end
    end
  end
end
