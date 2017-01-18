json.extract! venue, :id, :name, :description, :street_1, :street_2, :city, :state, :zip, :user_id, :created_at, :updated_at
json.url venue_url(venue, format: :json)