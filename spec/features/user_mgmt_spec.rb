require 'rails_helper'

RSpec.feature "ManageUser", type: :feature do
  context "Acting as an admin" do
    Steps "Registering and working with an admin user" do
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
  end
end
