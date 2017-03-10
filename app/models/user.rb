class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :review_ratings
  has_many :reviews
  has_one :profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
