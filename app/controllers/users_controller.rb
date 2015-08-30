class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  
   def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @follower = @user.following_users 
    @followed = @user.followed_users  
  end

  def new
    @user = User.new
  end
  
  def edit
   @user = User.find(params[:id])
  end
 
  def update
   @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "update ok!"
      redirect_to @user 
    else
      render 'edit'
    end
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @follower = @user.following_users
  end

  def followers
    @user = User.find(params[:id])
    @followed = @user.followed_users
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :local, :profile, :password,
                                 :password_confirmation)
  end
  def set_user
    @message = User.find(params[:id])
  end
end