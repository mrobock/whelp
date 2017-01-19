require 'rails_helper'

RSpec.feature "VenuePages", type: :feature do
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
      Given 'I am on the venues page' do
        visit '/venues'
      end
      Then 'I can click the New Venue link' do
        click_link 'New Venue'
      end
      And 'I can enter new venue info and create new venue' do
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
        fill_in 'venue[user_id]', with: user2.id
        click_button 'Create Venue'
        expect(page).to have_content("Name: Joe's Venue")
        expect(page).to have_content("Description: Joe's Awesome Venue")
      end
    end
  end
end
