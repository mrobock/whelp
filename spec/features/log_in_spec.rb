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
        expect(page).to have_content("Joe's Venue")
        expect(page).to have_content("Description: Joe's Awesome Venue")
      end
      And 'I click on "Venues"' do
        click_link 'Venues'
      end
      Then 'I can see a header and a table of venues containing information about said venues' do
        expect(page).to have_content("Venues")
        expect(page).to have_content("Description")
        expect(page).to have_content("Address")
        expect(page).to have_content("New Venue")
      end
      Then "I can add a new event" do
        click_on "Events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Joe's Venue", from: "Venue"
        click_on "Create Event"
      end
      Then 'I visit the events page and see a header and a table of venues containing information about said events' do
        visit "/events"
        expect(page).to have_content("Events")
        expect(page).to have_content("Venue")
        expect(page).to have_content("Description")
        expect(page).to have_content("New Event")
      end
    end

    Steps "I am going to the Landing page, registering, and logging in" do
       Given "I am registering a user" do
         visit '/my/users/sign_up'
         expect(page).to have_selector(:link_or_button, 'Sign in with Twitter')
       end
       Then "I am a registered user" do
         visit '/my/users/sign_up'
         expect(page).to have_selector(:link_or_button, 'Sign in with Twitter')
       end
       Then "I can click the sign in link and be taken to a sign in page" do
         visit '/my/users/sign_in'
         expect(page).to have_content('Sign in')
       end
       Then 'I am taken to a Log in page' do
         expect(page).to have_selector(:link_or_button, 'Sign in with Twitter')
       end
     end
   end

   context 'On the events page, signing in' do
     Steps "I am on the events page, I can sign in and be taken back to the events page" do
      Given "I am signing in" do
        visit '/events'
      Then 'I can sign in' do
        click_link 'Sign In'
      end
      Then 'I see the log in page' do
        visit '/my/users/sign_in'
        click_on 'Log in'
        expect(page).to have_content("Log in")
      end
      Then "I am taken back to the events page" do
        visit '/events'
        end
      end
    end
  end
  context 'On the events show page, signing in' do
    Steps "I am on the events page, I can sign in and be taken back to the events show page" do
     Given "I am signing in" do
       visit '/events/'
     Then 'I can sign in' do
       click_link 'Sign In'
     end
     Then 'I see the log in page' do
       visit '/my/users/sign_in'
       click_on 'Log in'
       expect(page).to have_content("Log in")
     end
     Then "I am taken back to the events show page" do
       visit '/events/'
       end
     end
   end
 end
 context 'On the venues page, signing in' do
   Steps "I am on the venues page, I can sign in and be taken back to the venues page" do
    Given "I am signing in" do
      visit '/venues'
    Then 'I can sign in' do
      click_link 'Sign In'
    end
    Then 'I see the log in page' do
      visit '/my/users/sign_in'
      click_on 'Log in'
      expect(page).to have_content("Log in")
    end
    Then "I am taken back to the venues page" do
      visit '/venues'
      end
    end
  end
 end
 context 'On the venues show page, signing in' do
  Steps "I am on the venues page, I can sign in and be taken back to the venues show page" do
   Given "I am signing in" do
     visit '/venues/'
   Then 'I can sign in' do
     click_link 'Sign In'
   end
   Then 'I see the log in page' do
     visit '/my/users/sign_in'
     click_on 'Log in'
     expect(page).to have_content("Log in")
   end
   Then "I am taken back to the venues show page" do
     visit '/venues/'
     end
   end
 end
 end
# end of rspec feature
end
