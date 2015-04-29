class Admin::UsersController < ApplicationController
  
  before_filter :ensure_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
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

end
