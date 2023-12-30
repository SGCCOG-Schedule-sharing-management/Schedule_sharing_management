class Public::AchievementsController < ApplicationController
  def new

    @schedule = Schedule.find(params[:schedule_id])
    @schedule_participants = @schedule.schedule_participants
    @achievement = Achievement.new
  end 
  
  def create
  end 
  
  def show
  end 
  
  def index
  end 
  
  def edit
  end 
  
  def update
  end
  
  def destroy
  end 
end
