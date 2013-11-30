class UsersController < ApplicationController
  
  before_action :ensure_user_logged_in, only:[:edit, :update]
  before_action :ensure_correct_user, only:[:edit, :update]
  before_action :ensure_admin_user, only:[:destroy]
  before_action :ensure_not_logged_in, only: [:new, :create]
  
  respond_to :html, :json, :xml
  
  def index
    @users=User.all
    respond_with(@user)
  end
  
  def new
    @user = User.new
    respond_with(@user)
  end
 
  
  def create
    @user = User.new(permitted_params)
    if @user.save then
      cookies[:logged] = true
      cookies[:user] = @user.username
      cookies.signed[:user_id] = @user.id
      flash[:success]="Welcome to the site: #{@user.username}"
    end
    respond_with(@user)
  end
 
    def show
      @user = User.find(params[:id])
      respond_with(@user)
    end
    
    def edit
      @user = User.find(params[:id])
      respond_with(@user)
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update(permitted_params) then
        flash[:success]="Successful user update: #{@user.username}"
      end
      respond_with(@user)
    end
      
    def destroy
      @user = User.find(params[:id])
      if !current_user? @user
        redirect_to users_path
        cookies.delete :user_id
        @user.destroy
        flash[:success] = "User destroyed"
        respond_with(@user)
      else
        flash[:danger] = "Unable to delete self"
        redirect_to root_path
      end
    end
      
      private
      
      def permitted_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
      
      def ensure_user_logged_in
        redirect_to login_path, flash: { :warning => "Must be logged in." } unless logged_in? 
      end
      
      def ensure_correct_user
        @user = User.find(params[:id])
        redirect_to root_path, flash: { :danger => "Must be logged in to correct user" } unless current_user?(@user)
      end
      
      def ensure_admin_user
        redirect_to users_path unless current_user.admin?
      end
      
    def ensure_not_logged_in
      redirect_to root_path, flash: { :warning => "Couldn't perform action" } unless !logged_in?
    end 
      
  
end
