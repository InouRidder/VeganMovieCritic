class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :review_ratings


  def user_rating

    if self.review_ratings.size > 0
      sum = 0
      self.review_ratings.each do |e|
        sum += e.rating
      end
        return sum / self.review_ratings.size
    else
      "Not Rated"
    end
  end

  def has_rated
    users = []
    if self.review_ratings.size > 0
      self.review_ratings.each do |e|
        users << e.user
      end
    end
    users.include?(user)
  end

end
