class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :venue, optional: true
  belongs_to :event, optional: true
end
