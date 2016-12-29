class HomeController < ApplicationController


  def home
    @disable_nav = true
    authorize (Review.first)
  end

end

