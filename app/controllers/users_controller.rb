class UsersController < ApplicationController
   # GET to /users/:id
   before_action :authenticate_user!
   
   def show
       @user = User.find(params[:id])
   end
   
   def index
      @users = User.includes(:profile)
   end
end