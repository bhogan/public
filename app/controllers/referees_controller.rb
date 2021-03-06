class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_contest_creator, only:[:new, :create, :edit, :update]
  
  def new
    @referee= current_user.referees.build
  end
  
  def index
    @referees= Referee.all
  end
  
  
  def create
    @referee= current_user.referees.build(permitted_params)
    if @referee.save then
      flash[:success] ="New referee #{@referee.name} created."
      redirect_to @referee
    else
      flash[:danger] = "New referee not #{@referee.name} created."
      render 'new'
    end
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
    
    
    def edit
 
    end
    
    def update

      if @referee.update_attributes(permitted_params) then
        flash[:success]="Successful referee update: #{@referee.name}"
        redirect_to @referee
      else
        flash[:danger]="Could not update referee #{@referee.name}"
        render 'edit'
      end
    end
      
    def destroy
      @referee = Referee.find(params[:id])
      if current_user?(@referee.user)
        @referee.destroy
        File::delete(@referee.file_location)
        flash[:success] = "Referee destroyed #{@referee.name}"
        redirect_to referees_path
      else
        flash[:danger] = "Unable to delete referee #{@referee.name}"
        redirect_to root_path
      end
    end

      
      
      
  private
  
  def permitted_params
    params.require(:referee).permit( :name, :rules_url, :players_per_game, :upload)
  end
  
  def ensure_contest_creator
    redirect_to root_path, flash: { :danger => "Invalid: You can't create contests" } unless current_user.contest_creator
  end
    
  def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Must be logged in." } unless logged_in? 
  end
      
  def ensure_correct_user
    @referee = Referee.find(params[:id])
    redirect_to root_path, flash: { :danger => "Not logged in to correct user" } unless current_user?(@referee.user)
  end
  
  
end
