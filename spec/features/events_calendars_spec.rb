require 'rails_helper'

RSpec.feature "EventsCalendars", type: :feature do
  context 'Seeing a calendar for events' do
    Steps 'Going to home page where events calendar lives' do
      Given 'I am on the home page' do
        visit '/'
      end
      Then 'I can see the events calendar' do
        expect(page).to have_css('div#eventsCalendar')
      end
    end
  end
end
