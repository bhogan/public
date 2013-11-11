class RefereesController < ApplicationController
  
  before_action :ensure_contest_creator, only:[:create]
  
  def new
    @referee= current_user.referees.build
  end
  
  def create
    @referee= current_user.referees.build(acceptable_params)
    if @referee.save
      flash[:success] ="Referee created."
      redirect_to @referee
    else
      render 'new'
    end
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
  
  private
  
  def acceptable_params
    params.require(:referee).permit( :name, :rules_url, :players_per_game, :upload)
  end
  
  def ensure_contest_creator
    redirect_to referee_path unless current_user.contest_creator?
  end
  
  
end