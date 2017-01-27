class Rating < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  belongs_to :venue, optional: true
  belongs_to :event, optional: true


  #
  # <%=  image_tag(some_path) do %>
  # <%=  content_tag(:p, "Your link text here") %>
  # <%  end %>

end
