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
end
