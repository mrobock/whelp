require 'rails_helper'

RSpec.feature "ShareFbtws", type: :feature do
  context 'Ratings were added to the venue and events show pages.' do
    Steps "I created a user, venue and event" do
      Given "and I am on the landing page" do
        visit "/"
      end
      Then "I can see a twitter AND a facebook share button" do
        expect(page).to have_css('.twitter-share-button')
        expect(page).to have_css('.fb-share-button')
      end
    end
  end
end
