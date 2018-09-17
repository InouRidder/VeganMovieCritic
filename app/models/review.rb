class Review < ApplicationRecord
  include Bootsy::Container

  mount_uploader :artwork, PhotoUploader

  belongs_to :movie
  belongs_to :user
  has_many :review_ratings, :dependent => :destroy
  after_create :set_ratings

  scope :approved, -> { where(approved: true)}
  scope :unapproved, -> { where.not(approved: true)}
  scope :newest, -> { where(approved: true).order(created_at: :desc)[0..9]}

  Review.set_ratings(@movie.reviews.approved)

  def set_ratings
    self.movie.reviews.approved.each do |review|
      review.set_rating
      review.save!
    end
  end

  def set_rating
    if self.review_ratings.size > 0
      sum = 0
      self.review_ratings.each do |e|
        sum += e.rating
      end
        self.review_rating = sum / self.review_ratings.size
    else
      "Not Rated"
    end
  end

  def has_rated(user)
    users = []
    if self.review_ratings.size > 0
      self.review_ratings.each do |e|
        users << e.user
      end
    end
    users.include?(user)
  end

  def approve
    self.approved = true
  end

end
