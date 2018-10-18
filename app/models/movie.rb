require_relative '../services/movie_api'
class Movie < ApplicationRecord

  include PgSearch
  pg_search_scope :search_title, :against => [:title]

  mount_uploader :poster, PhotoUploader

  has_many :reviews, :dependent => :destroy
  has_many :users, through: :reviews

  scope :by_rating, -> {where.not(rating: nil).order(rating: :desc)}
  scope :top10, -> { where('created_at >= ?', Time.now.beginning_of_year).order(rating: :desc)[0..9] }
  scope :most_reviewed, -> { order(times_reviewed: :desc)[0..9] }

  def has_reviewed?(user)
    users.include? user
  end

  def self.set_ratings
    movies = Movie.all
    movies.each do |movie|
      movie.rating = movie.set_rating
      movie.save!
    end
  end

  def has_reviewed?(user)
    users.include? user
  end

  def set_rating_and_times_reviewed
    reviews = self.reviews.approved
    if reviews.size > 0
      sum = 0.0
      reviews.each do |review|
        sum += review.rating
      end
      self.rating = ((sum / reviews.size.to_f)/2.0)
    else
      self.rating = 0
    end
    self.times_reviewed = reviews.size
    self.save
  end

  def presentable_attributes
    self.attributes.except("id", "title", "created_at", "updated_at", "rating", "poster", "imdb_poster", "times_reviewed", "released").reject {|key, value| value == "N/A" || value == nil}
  end

  def self.set_times_reviewed
    Movie.all.each do |movie|
      movie.times_reviewed = movie.reviews.where(approved: true).size
      movie.save!
    end
  end

  def self.search_movie(title)
    MovieApi.new(title).search
  end

  def reviewed?
    self.reviews.size > 0
  end

end
