json.extract! venue_review, :id, :review, :user_id, :venue_id, :created_at, :updated_at
json.url venue_review_url(venue_review, format: :json)