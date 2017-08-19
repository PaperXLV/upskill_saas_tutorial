class ProfilesController < ApplicationController
  # GET to /users/:user_id/profile/new 
  before_action :authenticate_user!
  before_action :only_current_user
  
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    @user = User.find( params[:user_id] )
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  def update
    # retrieve user and update their profile
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_path(id: params[:user_id] )
    else
      flash[:danger] = "Error with updating profile"
      render action: :edit
    end
  end
  
  # Whitelisting the params to use, prevents injecting
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end