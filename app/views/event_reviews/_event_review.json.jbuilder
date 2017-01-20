json.extract! event_review, :id, :review, :user_id, :event_id, :created_at, :updated_at
json.url event_review_url(event_review, format: :json)