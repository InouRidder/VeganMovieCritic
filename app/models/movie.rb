class Movie < ApplicationRecord

  include PgSearch
  pg_search_scope :search_title, :against => [:title]

  has_many :reviews, :dependent => :destroy


  def best_review
    self.reviews.where(approved: true).order(rating: :desc)[0]
  end

  def set_rating
    if self.reviews.size > 0
      sum = 0
      self.reviews.each do |e|
        sum += e.rating
      end
        self.rating = sum / self.reviews.size
    else
      self.rating = 0
    end
  end

  def set_times_reviewed
    self.times_reviewed = self.reviews.where(approved: true).size
    self.save!
  end

  def user_rating
    a = 0
    if self.reviews.any?
      self.reviews.each do |e|
        a += e.rating
      end
        return (a / self.reviews.size)
    end
  end
end
