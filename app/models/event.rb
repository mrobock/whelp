class Event < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  belongs_to :venue
  validates :venue, presence: true

  has_many :event_reviews
  has_many :comments
  has_many :users, through: :rsvp
  has_many :ratings

  validates :name, presence: true

#Adding paperclip
  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "350x275#", xlarge: "400x400#" }, :default_url => "default_:style.png"
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }


  #Adding Ratyrate
  # ratyrate_rateable "name"
end
