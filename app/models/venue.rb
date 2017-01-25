class Venue < ApplicationRecord

  belongs_to :user
  has_many :events
  has_many :venue_reviews

  has_many :comments

  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { in: 10..500 }


#Adding paperclip
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => "default.png"
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }

  #Adding ratyrate
  ratyrate_rateable "name"

  after_validation :geocode
  geocoded_by :full_address

  def full_address
    street_1 + ", " + street_2 + ", " + city + ", " + state + ", " + zip
  end
end
