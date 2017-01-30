class Venue < ApplicationRecord

  belongs_to :user
  validates :user, presence: true

  has_many :events
  has_many :venue_reviews

  has_many :ratings

  has_many :comments

  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { in: 10..500 }

  resourcify

  #Adding Gmaps via geocoder
  geocoded_by :full_address
  after_validation :geocode

#Adding paperclip
  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "350x250#", xlarge: "400x400#" }, :default_url => "default_:style.png"
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }

#Adding ratyrate
# ratyrate_rateable "name"

private
  def full_address
    street_1.to_s + ' ' + street_2.to_s + ', ' + city.to_s + ', ' + state.to_s + ', ' + ', ' + zip.to_s
  end
end
