require 'rails_helper'

RSpec.describe "venues/new", type: :view do
  before(:each) do
    assign(:venue, Venue.new(
      :name => "MyString",
      :description => "MyText",
      :street_1 => "MyString",
      :street_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :user => nil
    ))
  end

  it "renders new venue form" do
    render

    assert_select "form[action=?][method=?]", venues_path, "post" do

      assert_select "input#venue_name[name=?]", "venue[name]"

      assert_select "textarea#venue_description[name=?]", "venue[description]"

      assert_select "input#venue_street_1[name=?]", "venue[street_1]"

      assert_select "input#venue_street_2[name=?]", "venue[street_2]"

      assert_select "input#venue_city[name=?]", "venue[city]"

      assert_select "input#venue_state[name=?]", "venue[state]"

      assert_select "input#venue_zip[name=?]", "venue[zip]"

      assert_select "input#venue_user_id[name=?]", "venue[user_id]"
    end
  end
end
