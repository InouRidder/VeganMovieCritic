class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy


  def highest
    movies = Movie.all
    return movies.sort_by { |e| e.rating }
  end

  def newest
    movies = Movie.all
    return movies.sort_by { |e| e.created_at }
  end

  def set_rating
    sum = 0
    self.reviews.each do |x|
      sum += x.rating
    end
    if self.reviews.length != 0
    rating = sum / self.reviews.length
    return rating
    else
      "This movie has not been rated!"
    end
  end

end
