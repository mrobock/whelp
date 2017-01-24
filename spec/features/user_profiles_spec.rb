require 'rails_helper'

RSpec.feature "UserProfiles", type: :feature do
  context "Landing" do
    Steps "Going to Landing page" do
      Given "I visit localhost 3000" do
        visit "/"
      end
      Then "I see the site's welcome message!" do
        expect(page).to have_content("Whelcome to Whelp!")
      end
    end
  end

  context "Registering a User" do
    Steps "Going to a registration page and filling out a form" do
      Given "I am on the landing (root) page" do
        visit "/"
      end
      And "I click the 'Sign Up' button" do
        click_link "Sign Up"
      end
      Then "I see a registration form that I can fill out" do
        expect(page).to have_content("Sign up")
        fill_in 'user[username]', with: "ssmith"
        fill_in 'user[email]', with: "ssmith@test.com"
        fill_in 'user[password]', with: "password"
        fill_in 'user[password_confirmation]', with: "password"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
      end
      And "I can submit the registration form succesfully having filled out the required fields" do
        click_button 'Sign up'
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
      Then "I can view my profile" do
        click_on "Profile"
        expect(page).to have_content("Hi, ssmith!")
        expect(page).to have_content("ssmith@test.com")
      end
      Then "I can edit my profile" do
        click_on "Edit"
        fill_in 'user[username]', with: "philTest"
        fill_in 'user[email]', with: "phil@test.com"
        fill_in 'user[password]', with: "tester"
        fill_in 'user[password_confirmation]', with: "tester"
        fill_in "user[first_name]", with: "Phil"
        fill_in "user[last_name]", with: "Test"
        fill_in "user[current_password]", with: "password"
        attach_file('user[image]', 'spec/images/profile.jpeg')
        click_on "Update"
      end
      And "I can see the changes reflected on my profile page" do
        click_on "Profile"
        expect(page).to have_content("Hi, philTest!")
        expect(page).to have_content("Email: phil@test.com")
        expect(page).to have_content("First Name: Phil")
        expect(page).to have_content("Last Name: Test")
      end
    end
  end
end
