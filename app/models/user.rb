class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :review_ratings
  has_many :reviews
  has_one :profile
  validates :email, uniqueness: { case_sensitive: false, message: "E-mail in use" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
