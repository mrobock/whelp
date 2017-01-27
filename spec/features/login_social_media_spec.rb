require 'rails_helper'

RSpec.feature "LoggingIn", type: :feature do
  context "I register a user with facebook." do
    # Test MODE FOR OMNIAUTH!
    # OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:Facebook] = OmniAuth::AuthHash.new({
    #   :provider => 'Facebook',
    #   :uid => '123545',
    #   email: 'tester@tester.com',
    #   name: 'Tester Man'
    #   }
    #   # etc.
    # })
    Steps "I am going to the Landing page, registering, and logging in" do
      Given "I am registering a user" do
        visit '/my/users/sign_up'
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
        # click_link 'Sign in with Facebook'
        # expect(page).to have_content("Successfully authenticated from Facebook account")
      end
      Then "I am a registered user" do
        visit '/my/users/sign_up'
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
      end
      Then "I can click the sign in link and be taken to a sign in page" do
        visit '/my/users/sign_in'
        expect(page).to have_content('Sign in')
      end
      Then 'I am taken to a Log in page' do
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
      end
    end
  end
end
