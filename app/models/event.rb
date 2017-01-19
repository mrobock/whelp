class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  validates :name, presence: true
end
