module ApplicationHelper
  def active?(value)
    if request.original_url.ends_with?(value)
      "active"
    else
      ""
    end
  end

  def upcase_first(s)
    s[0].upcase + s[1..s.length]
  end

  def date_to_s(datetime)
    if datetime.today?
      s = "today at " + datetime.strftime("%l:%M %p")
    elsif datetime.strftime("%-m%-d%Y") == Date.yesterday.strftime("%-m%-d%Y")
      s = "yesterday at " + datetime.strftime("%l:%M %p")
    elsif datetime.strftime("%-m%e%Y") == Date.tomorrow.strftime("%-m%e%Y")
      s = "tomorrow at " + datetime.strftime("%l:%M %p")
    else
      s = datetime.strftime("%-m/%-d/%Y at %l:%M %p")
    end
    s
  end
end
