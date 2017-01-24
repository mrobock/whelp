class Comment < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  
  belongs_to :venue, optional: true
  belongs_to :event, optional: true
end
