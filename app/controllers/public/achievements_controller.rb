class Public::AchievementsController < ApplicationController
  def new
    @schedule = Schedule.find(params[:schedule_id])
    @schedule_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @achievement = Achievement.new
  end


  def create
    @schedule = Schedule.find(params[:schedule_id])
    @schedule_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @achievement = Achievement.new(achievement_params)
    #@achievement.participant = @schedule_participants.user.nickname
    @achievement.participant = @schedule_participants.map { |participant| participant.user.nickname }.join(', ')

    if @achievement.save!
      flash[:success] = "活動報告を投稿しました"
      redirect_to schedule_achievement_path(@achievement)
    else
      flash[:error] = "活動報告は投稿出来ませんでした"
      render :new
    end
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def achievement_params
    params.require(:achievement).permit(:title, :participant, :content, :comment, :post_image)
  end

end
