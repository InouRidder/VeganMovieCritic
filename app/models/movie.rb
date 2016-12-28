class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy



  def user_rating
    a = 0
    if self.reviews.any?
      self.reviews.each do |e|
        a += e.rating
      end
        return (a / self.reviews.length)
    end
  end
end
