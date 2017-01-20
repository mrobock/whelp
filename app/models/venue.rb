class Venue < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :comments

  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { in: 10..500 }
end
