class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :event_reviews
  validates :name, presence: true
end
