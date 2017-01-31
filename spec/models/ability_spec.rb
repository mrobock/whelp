require 'rails_helper'

RSpec.describe Ability, type: :model do
  it "must exist when initialized with user" do
    u = User.new
    expect{Ability.new(u)}.to_not raise_error
  end
  it "must make Users with :default or :admin role able to see everything" do
    u = User.new
    u.add_role :default
    a = User.new
    a.remove_role :default
    a.add_role :admin

    default = Ability.new(u)
    admin = Ability.new(a)

    expect(default.can? :read, :all).to eq true
    expect(admin.can? :read, :all).to eq true
  end
  it "must allow a default user to create a venue, but only be allowed to manage their own venue" do
    u = User.new
    u.id = 1
    u.add_role :default
    u1 = User.new
    u1.id = 2
    u1.add_role :default

    venue = Venue.new
    venue.user = u
    venue.save
    u.save

    venue1 = Venue.new
    venue1.user = u1
    venue1.save
    u1.save

    default = Ability.new(u)

    expect(default.can? :create, Venue).to eq true
    expect(default.can? :manage, venue, user_id: u.id).to eq true
    expect(default.cannot? :manage, venue1, user_id: u1.id).to eq true
  end
  it "must allow a default user to create a venue, but only be allowed to manage their own venue" do
    u = User.new
    u.id = 1
    u.add_role :default
    u1 = User.new
    u1.id = 2
    u1.add_role :default

    event = Event.new
    event.user = u
    event.save
    u.save

    event1 = Venue.new
    event1.user = u1
    event1.save
    u1.save

    default = Ability.new(u)

    expect(default.can? :create, Event).to eq true
    expect(default.can? :manage, event, user_id: u.id).to eq true
    expect(default.cannot? :manage, event1, user_id: u1.id).to eq true
  end
  it "must not allow an admin to create a venue or event, but be allowed to read, update, and destroy all of them" do
    a = User.new
    a.remove_role :default
    a.add_role :admin

    admin = Ability.new(a)
    expect(admin.can? :create, Venue).to eq false
    expect(admin.can? :rud, Venue).to eq true
    expect(admin.can? :create, Event).to eq false
    expect(admin.can? :rud, Event).to eq true
  end
  it "must not allow an admin to create or manage an RSVP" do
    a = User.new
    a.remove_role :default
    a.add_role :admin

    admin = Ability.new(a)

    expect(admin.can? :create, Rsvp).to eq false
    expect(admin.can? :manage, Rsvp).to eq false
  end
  it "must only let a default user create an RSVP" do
    a = User.new

    default = Ability.new(a)

    rsvp = Rsvp.new(user_id: a.id)

    expect(default.can? :create, Rsvp).to eq true
    expect(default.can? :manage, rsvp, user_id: a.id).to eq true
  end
  it "must not allow an admin to create or manage a rating" do
    a = User.new
    a.remove_role :default
    a.add_role :admin

    admin = Ability.new(a)

    expect(admin.can? :create, Rating).to eq false
    expect(admin.can? :manage, Rating).to eq false
  end
  it "must only let a default user create a rating" do
    a = User.new

    default = Ability.new(a)

    rating = Rating.new(user_id: a.id)

    expect(default.can? :create, Rating).to eq true
    expect(default.can? :manage, rating, user_id: a.id).to eq true
  end
end
