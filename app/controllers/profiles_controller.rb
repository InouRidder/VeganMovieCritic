class ProfilesController < ApplicationController
  before_action :find_user
  before_action :find_profile, only: [:update]

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.create(profile_params)
    current_user.profile = @profile
    current_user.save!
    authorize @profile
    redirect_to profiles_path(@profile)
  end

  def edit
    @profile = current_user.profile
    current_user.email = params[:email] if params[:email]
    authorize @profile
  end

  def update
    @profile.update(profile_params)
    @profile.save!
    current_user.profile = @profile
    current_user.save!
    authorize @profile
    redirect_to profiles_path(@profile)
  end

  def destroy
    @profile = current_user.profile
    @profile.destroy!
    redirect_to movies_path
  end

  def index
    @profile = current_user.profile
    @reviews = @profile.user.reviews.newest
    policy_scope(@profile)
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :first_name, :last_name, :info, :country)
  end

  def find_user
    @user = current_user
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

end
