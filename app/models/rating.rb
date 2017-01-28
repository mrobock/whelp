class Rating < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  belongs_to :venue, optional: true
  belongs_to :event, optional: true

  validates :rating, presence: true, inclusion: { in: 1..5}


  #
  # <%=  image_tag(some_path) do %>
  # <%=  content_tag(:p, "Your link text here") %>
  # <%  end %>

end
