class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :event_reviews
  has_many :comments
  has_many :users, through: :rsvp
  validates :name, presence: true

#Adding paperclip
  has_attached_file :image, styles: {small: '64x64', medium: '100x100', large: '200x200'}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  #Adding Ratyrate
  ratyrate_rateable "name"
end
