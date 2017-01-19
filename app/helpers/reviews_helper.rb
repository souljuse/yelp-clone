module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    stars = rating.round
    ('★' * stars) + ('☆' * (5-stars))
  end
end
