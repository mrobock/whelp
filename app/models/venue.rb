class Venue < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :venue_reviews

  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { in: 10..500 }

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }
end
