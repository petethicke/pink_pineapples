class Admin::UsersController < ApplicationController
  
  before_filter :ensure_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @admin_user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def ensure_admin
    if !current_user
      flash[:alert] = 'You need to log in!'
      redirect_to '/sessions/new'
    elsif !current_user.admin 
      flash[:alert] = "You are not an admin!"
      redirect_to '/'
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin)
  end

end
