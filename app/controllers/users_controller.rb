class UsersController < ApplicationController
  
  def index
    @users=User.all
  end
  
  def new
    @user = User.new
  end
 
  
  def create
    permitted_params = params.require(:user).permit(:username, 
                                                    :password, 
                                                    :password_confirmation,
                                                    :email)
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
       permitted_params = params.require(:user).permit(:username, 
                                                      :password, 
                                                      :password_confirmation,
                                                      :email)
      @user = User.find(params[:id])
      
      if @user.update(permitted_params) then
        redirect_to @user
      else
        render 'edit'
      end
    end
    
  
end
