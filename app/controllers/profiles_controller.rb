class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
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
    
  end

  def update
    
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :bio, :rating, :user_id)
  end
end
