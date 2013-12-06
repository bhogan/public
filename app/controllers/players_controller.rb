class PlayersController < ApplicationController
 
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

  
  def new
    contest= Contest.find(params[:contest_id])
    @player= contest.players.build
  end
  
  def index
    @players= Player.all
  end
  
  
  def create
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build(permitted_params)
    @player.user = current_user
    if @player.save then
      flash[:success] = "Player #{@player.name} created."
      redirect_to @player
    else
      render 'new'
    end
  end
  
  def show
    @player = Player.find(params[:id])
  end
    
    
    def edit
    end
    
     def update
       if @player.update_attributes(permitted_params)
        flash[:success] = "Player #{@player.name} updated."
        redirect_to @player
      else
        render 'edit'
      end
    end
      
    def destroy
      @player = Player.find(params[:id])
      if current_user? (@player.user)
        @player.destroy
        flash[:success] = "Player destroyed"
        redirect_to contest_players_path(@player.contest)
      else
        flash[:danger] = "Unable to delete player"
        redirect_to root_path
      end
    end
  
  private
  
  def permitted_params
    params.require(:player).permit( :name, :contest_id, :description, :upload, :download, :playable)
  end
    
  def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Must be logged in." } unless logged_in? 
  end
      
  def ensure_correct_user
    @player = Player.find(params[:id])
    redirect_to root_path, flash: { :danger => "Must be logged in to correct user" } unless current_user?(@player.user)
  end
  
  
end
