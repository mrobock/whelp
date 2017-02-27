module RatingsHelper
  def format average
    '%.2f' % average.to_f.round(2)
  end

  def show_rating ratings
    num = ratings.length.to_i
    if (num == 1)
      num.to_s + " Rating"
    else
      num.to_s + " Ratings"
    end
  end
end
