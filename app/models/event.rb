class Event < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  belongs_to :venue
  validates :venue, presence: true

  has_many :event_reviews
  has_many :comments
  has_many :users, through: :rsvp

  validates :name, presence: true

#Adding paperclip
  has_attached_file :image, styles: {small: '64x64', medium: '100x100', large: '200x200'}, :default_url => "default.png"
  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }


  #Adding Ratyrate
  # ratyrate_rateable "name"
end
