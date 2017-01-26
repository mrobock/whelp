require 'rails_helper'

RSpec.describe Role, type: :model do
  it "must exist" do
    expect{Role.new}.to_not raise_error
  end
  it "must be addable to a user" do
    u = User.new
    r = Role.new(name: "random", resource_type: "User")
    u.add_role r
    expect(u.has_role? r).to eq true
  end
end
