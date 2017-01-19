require 'rails_helper'

RSpec.describe User, type: :model do
  it "must exist" do
    expect{User.new}.to_not raise_error
  end
  it "must start with a username that is an empty string" do
    user = User.new
    expect(user.username).to be_a(String)
    expect(user.username).to eq("")
  end
  it "must start with an email that is an empty string" do
    user = User.new
    expect(user.email).to be_a(String)
    expect(user.email).to eq("")
  end
  it "must start with an encrypted password that is an empty string" do
    user = User.new
    expect(user.encrypted_password).to be_a(String)
    expect(user.encrypted_password).to eq("")
  end
  it "must be initialized with a username, email, password, and password confirmation, and be saveable" do
    user = User.new(username: "dummy1", email: "dummy@home.com", password: "password1", password_confirmation: "password1", first_name: "firstname", last_name: "lastname")
    expect(user.save).to eq true
  end
  it "must have the conditions of the previous test, but also be able to initialize with first name, last name, full street address, city, state, and zip code, and be saveable" do
    user = User.new(username: "dummy1", email: "dummy@home.com", password: "password1", password_confirmation: "password1", first_name: "dumdum", last_name: "deedum", street_1: "123 Dumb St", street_2: "Apt. 22", city: "Dumb City", state: "California", zip: "92116")
    expect(user.save).to eq true
  end
  it "must be able to, upon creating a user, be able to be found, with the correct values" do
    user = User.new(username: "dummy1", email: "dummy@home.com", password: "password1", password_confirmation: "password1", first_name: "dumdum", last_name: "deedum", street_1: "123 Dumb St", street_2: "Apt. 22", city: "Dumb City", state: "California", zip: "92116")
    user.save

    u = User.find_by(username: "dummy1")
    expect(u.username).to eq("dummy1")
    expect(u.email).to eq("dummy@home.com")
    expect(u.first_name).to eq("dumdum")
    expect(u.last_name).to eq("deedum")
    expect(u.street_1).to eq("123 Dumb St")
    expect(u.street_2).to eq("Apt. 22")
    expect(u.city).to eq("Dumb City")
    expect(u.state).to eq("California")
    expect(u.zip).to eq("92116")
  end
end
