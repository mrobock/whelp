require 'rails_helper'

RSpec.describe "venues/index", type: :view do
  before(:each) do
    assign(:venues, [
      Venue.create!(
        :name => "Name",
        :description => "MyText",
        :street_1 => "Street 1",
        :street_2 => "Street 2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :user => nil
      ),
      Venue.create!(
        :name => "Name",
        :description => "MyText",
        :street_1 => "Street 1",
        :street_2 => "Street 2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :user => nil
      )
    ])
  end

  it "renders a list of venues" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Street 1".to_s, :count => 2
    assert_select "tr>td", :text => "Street 2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
