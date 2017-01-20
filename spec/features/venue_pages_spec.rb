require 'rails_helper'

RSpec.feature "VenuePages", type: :feature do
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

  context 'Going to the venues page' do
    Steps 'Seeing the venues page' do
      Given 'I am on the venues page' do
        visit '/venues'
      end
      Then 'I can see the venues header' do
        expect(page).to have_content("Venues")
      end
    end
  end

  context 'Creating a new venue' do
    Steps 'Going to the create new venue page' do
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
      Then 'I can navigate to the on the venues page' do
        visit '/venues'
      end
      And 'I can click the New Venue link' do
        click_link 'New Venue'
      end
      Then 'I can enter new venue info and create new venue' do
        user1 = User.new(username: "Joe1", email: "joe@home.com", password: "password", password_confirmation: "password", first_name: "firstname", last_name: "lastname")
        user1.save
        user2 = User.find_by_username("Joe1")

        fill_in 'venue[name]', with: "Joe's Venue"
        fill_in 'venue[description]', with: "Joe's Awesome Venue"
        fill_in 'venue[street_1]', with: "123 Joe Street"
        fill_in 'venue[street_2]', with: "Suite 1"
        fill_in 'venue[city]', with: "San Diego"
        fill_in 'venue[state]', with: "CA"
        fill_in 'venue[zip]', with: "92109"
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_button 'Create Venue'
        expect(page).to have_content("Name: Joe's Venue")
        expect(page).to have_content("Description: Joe's Awesome Venue")
      end

      When 'I click "Edit"' do
        click_on 'Edit'
      end
      And 'I attach an image file and click "Update Venue"' do
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Update Venue"
      end
      Then 'I can see the picture' do
        expect(page).to have_css('img')
      end
    end
  end
end
