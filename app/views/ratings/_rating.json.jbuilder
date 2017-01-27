json.extract! rating, :id, :rating, :user_id, :venue_id, :event_id, :created_at, :updated_at
json.url rating_url(rating, format: :json)