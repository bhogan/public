class UsersController < ApplicationController
  
  before_action :ensure_user_logged_in, only:[:edit, :update]
  before_action :ensure_correct_user, only:[:edit, :update]
  before_action :ensure_admin_user, only:[:destroy]
  
  def index
    @users=User.all
  end
  
  def new
    @user = User.new
  end
 
  
  def create
    @user = User.new(permitted_params)
    if @user.save then
      flash[:success]="welcome to the site: #{@user.username}"
      cookies[:logged] = true
      cookies[:user] = @user.username
      cookies.signed[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end
 
    def show
      @user = User.find(params[:id])
    end
    
    def edit
      @user = User.find(params[:id])
    end
    
    def update
      if @user.update(permitted_params) then
        flash[:success]="Successful user update: #{@user.username}"
        redirect_to @user
      else
        render 'edit'
      end
    end
      
    def destroy
      if !current_user? @user
        redirect_to users_path
        cookies.delete :user_id
        if @user.destroy
          flash[:success] = "Delete was a success"
        else
          flash[:danger] = "Error"
        end
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
        redirect_to login_path unless logged_in?
      end
      
      def ensure_correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless current_user?(@user)
      end
      
      def ensure_admin_user
        redirect_to users_path unless current_user.admin?
      end

      
  
end
