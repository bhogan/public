class RefereesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_contest_creator, only:[:new, :create, :edit, :update]
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @referee= current_user.referees.build
  end
  
  def index
    @referees= Referee.all
  end
  
  
  def create
    @referee= current_user.referees.build(permitted_params)
    if @referee.save then
      flash[:success] ="Referee #{@referee.name} created."
      redirect_to @referee
    else
      render 'new'
    end
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
    
    
    def edit
    end
    
    def update
      @referee = Referee.find(params[:id])
      if @referee.update_attributes(permitted_params) then
        flash[:success]="Successful referee update: #{@user.username}"
        redirect_to @referee
      end
        render 'edit'
    end
      
    def destroy
      @referee = Referee.find(params[:id])
      if !current_user? (@referee.user)
        redirect_to referees_path
        @referee.destroy
        flash[:success] = "Referee destroyed"
      else
        flash[:danger] = "Unable to delete referee"
        redirect_to root_path
      end
    end
  
  private
  
  def permitted_params
    params.require(:referee).permit( :name, :rules_url, :players_per_game, :upload)
  end
  
  def ensure_contest_creator
    redirect_to root_path, flash: { :danger => "You can't create contests" } unless current_user.contest_creator?
  end
    
  def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Must be logged in." } unless logged_in? 
  end
      
  def ensure_correct_user
    @referee = Referee.find(params[:id])
    redirect_to root_path, flash: { :danger => "Must be logged in to correct user" } unless current_user?(@referee)
  end
  
  
end
