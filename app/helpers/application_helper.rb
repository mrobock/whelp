module ApplicationHelper
  def active?(value)
    if request.original_url.ends_with?(value)
      "active"
    else
      ""
    end
  end
end
