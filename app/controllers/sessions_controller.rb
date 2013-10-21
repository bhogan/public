class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      cookies[:logged] = true
      cookies[:user] = @user.username
      cookies.signed[:user_id]=@user.id
      flash[:success] = "#{@user.username} logged in"
      redirect_to @user
     else
       flash.now[:danger] = "Invalid username or password"
       render 'new'
    end
  end
  
  def destroy
    @current_user = nil
    flash[:info] = "Logged out"
    cookies.delete :user_id
    cookies.delete :logged
    cookies.delete :user
    redirect_to login_path
  end
  
end
