class UsersController < ApplicationController
  
  def index
    @users=User.all
  end
  
  def new
    @user = User.new
  end
 
  
  def create
    @user = User.new(permitted_params)
    if @user.save then
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
      @user = User.find(params[:id])
      
      if @user.update(permitted_params) then
        redirect_to @user
      else
        render 'edit'
      end
    end
    
      def permitted_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
      
      def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
      end
  
end
