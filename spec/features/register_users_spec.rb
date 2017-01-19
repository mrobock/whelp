require 'rails_helper'

RSpec.feature "RegisterUser", type: :feature do
  context "Landing page" do
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
    end
  end
end
