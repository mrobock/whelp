require 'rails_helper'

RSpec.feature "LoggingIn", type: :feature do
  context "I register a user." do
    Steps "I am going to the Landing page, registering, and logging in" do
      Given "I am registering a user" do
        visit '/my/users/sign_up'
        fill_in 'user[username]', with: "ssmith"
        fill_in 'user[email]', with: "ssmith@test.com"
        fill_in 'user[password]', with: "password"
        fill_in 'user[password_confirmation]', with: "password"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
        click_button 'Sign up'
      end
      And "I log out" do
        click_link 'Sign Out'
      end
      Then "I can click the log in link and be taken to a log in page" do
        click_link 'Sign In'
        expect(page).to have_content('Log in')
      end
      And "I can fill in the login field with my email, with the password" do
        fill_in 'user[login]', with: 'ssmith@test.com'
        fill_in 'user[password]', with: 'password'
      end
      Then "I can click Log in and be succesfully logged in and redirected to the home page!" do
        click_button 'Log in'
        expect(page).to have_content("Signed in successfully.")
      end
      When "I log out again" do
        click_link 'Sign Out'
      end
      And "I click the log in link and am taken to the log in page again" do
        click_link 'Sign In'
        expect(page).to have_content('Log in')
      end
      And "I can fill in the login field with my username, with the password" do
        fill_in 'user[login]', with: 'ssmith'
        fill_in 'user[password]', with: 'password'
      end
      Then "I can click Log in and be succesfully logged in and redirected to the home page again!" do
        click_button 'Log in'
        expect(page).to have_content("Signed in successfully.")
      end
    end
  end

  context 'Using the navbar to find venues or events' do
    Steps 'I can use the navbar to find a list of venues' do
      Given 'I am on the home page' do
        visit '/'
      end
      And 'I click on "Venues"' do
        click_link 'Venues'
      end
      Then 'I can see a header and a table of venues containing information about said venues' do
        expect(page).to have_content("Venues")
        expect(page).to have_content("Description")
        expect(page).to have_content("Street Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zip")
      end
    end

    Steps 'I can use the navbar to find a list of events' do
      Given 'I am on the home page' do
        visit '/'
      end
      And 'I click on "Events"' do
        click_link 'Events'
      end
      Then 'I can see a header and a table of venues containing information about said events' do
        expect(page).to have_content("Name")
        expect(page).to have_content("Date")
        expect(page).to have_content("Venue")
        expect(page).to have_content("Description")
        expect(page).to have_content("Host")
      end
    end
  end
end
