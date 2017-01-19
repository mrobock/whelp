class Venue < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { in: 10..500 }
end
