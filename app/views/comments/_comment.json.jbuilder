json.extract! comment, :id, :title, :text, :user_id, :venue_id, :event_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)