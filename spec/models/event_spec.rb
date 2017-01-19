require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'should have name date venue' do
    user1 = User.new(username: "mrin", email: 'mrin', password: "mrin")
    venue = Venue.new(name: "Josh")
    venue.user = user1

    event = Event.new(name: "first event", date: "01/02/2018")
    event.venue = venue

    expect(event.save).to eq true

    event2 = Event.find_by_name("first event")
    expect(event2.venue.name). to eq "Josh"
    expect(event2.date).to eq "01/02/2018"
  end
end
