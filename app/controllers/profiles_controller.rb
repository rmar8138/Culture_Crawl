class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @profiles = Profile.all
  end

  def show
    if Profile.exists?(params[:id])
      @profile = Profile.find(params[:id])
    else
      redirect_to new_profile_path
    end
  end

  def new
    # redirect to show profile if user already has a profile
    @user = User.find(current_user.id)
    if @user.profile
      redirect_to @user.profile
    else
      @profile = Profile.new
    end
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.create_profile(profile_params)

    if @profile
      redirect_to profile_path(@profile)
    else
      render "new"
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :bio, :rating, :user_id)
  end
end
