require 'json'
require 'open-uri'

class Movie < ApplicationRecord

  include PgSearch
  pg_search_scope :search_title, :against => [:title]

  mount_uploader :poster, PhotoUploader


  has_many :reviews, :dependent => :destroy
  has_many :users, through: :reviews

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

  def self.set_times_reviewed
    Movie.all.each do |movie|
      movie.times_reviewed = movie.reviews.where(approved: true).size
      movie.save!
    end
  end

  def self.search_movie(title)
    url = "http://www.omdbapi.com/?t=#{title}&y=&plot=short&r=json"
    if returned_data = open(url).returned_data
      data = JSON.parse(returned_data)
      if data["Response"] == "False"
        false
      else
        @movie = Movie.new
        @movie.title = data["Title"]
        @movie.released = data["Released"]
        @movie.runtime = data["Runtime"]
        @movie.genre = data["Genre"]
        @movie.plot = data["Plot"]
        @movie.actors = data["Actors"]
        @movie.awards = data["Awards"]
        @movie.imdb_poster = data["Poster"]
        @movie.imdbrating = data["imdbrating"]
        @movie.country = data["Country"]
        @movie.language = data["Language"]
        @movie.director = data["Director"]
        @movie.save!
        return @movie
      end
    else
      false
    end
  end

  def reviewed?
    self.reviews.size > 0
  end

end
