RSpec.feature "LoggingIn", type: :feature do
  context "I register a user with facebook." do
    Steps "I am going to the Landing page, registering, and logging in" do
      Given "I am registering a user" do
        visit '/my/users/sign_up'
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
      end
      Then "I am a registered user" do
        visit '/my/users/sign_up'
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
      end
      Then "I can click the sign in link and be taken to a sign in page" do
        click_on 'Sign In'
        expect(page).to have_content('Sign in')
      end
      Then 'I am taken to a Log in page' do
        expect(page).to have_selector(:link_or_button, 'Sign in with Facebook')
      end
    end
  end
end
