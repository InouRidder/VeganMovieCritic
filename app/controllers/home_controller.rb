class HomeController < ApplicationController
skip_before_action :authenticate_user!, only: [:home, :landing]

  def home
    @disable_nav = true
    authorize (Review.first)
  end

  def landing
    @disable_nav = true
    authorize (Review.first)
  end
end

