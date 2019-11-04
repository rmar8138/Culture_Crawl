class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @profiles = Profile.all
  end

  def show
    if Profile.exists?(params[:id])
      @profile = Profile.find(params[:id])
      @attending = @profile.user.attendees.map do |crawl|
        Crawl.find(crawl.crawl_id)
      end
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
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
   
    if @profile.save
      redirect_to profile_path(@user.profile)
    else
      render "new"
    end
  end

  def edit
    @profile = User.find(params[:id]).profile

    if @profile.user_id != current_user.id
      redirect_to profile_path(@profile)
    end
  end

  def update
    @profile = User.find(current_user.id).profile
    if @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :bio, :rating, :user_id, :profile_image)
  end
end
