class Public::AchievementsController < ApplicationController
  def new
    @schedule = Schedule.find(params[:schedule_id])
    @schedule_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @achievement = Achievement.new
  end



def create
  @schedule = Schedule.find(params[:schedule_id])
  @achievement = Achievement.new(achievement_params)
  @achievement.schedule = @schedule

  # Scheduleのスケジュール参加者を取得
  @schedule_participants = @schedule.schedule_participants.where(attendance_status: 'joining')

  selected_nicknames = params[:participants] || [] # チェックされたニックネームの配列を取得

  selected_users = User.where(nickname: selected_nicknames) # チェックされたニックネームに対応するユーザーを取得
  participant_names = selected_users.map(&:nickname).join(', ') # 選択されたユーザーのニックネームを保存

  @achievement.participant = participant_names # @achievementのparticipantを設定

  if @achievement.save
    flash[:success] = "活動報告を投稿しました"
    redirect_to schedule_achievement_path(@achievement)
  else
    flash[:error] = "活動報告の投稿に失敗しました: #{@achievement.errors.full_messages.join(', ')}"
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
   #params.require(:achievement).permit(:title, :participant, :content, :comment, :post_image)
    params.require(:achievement).permit(:title, :participant, :content, :comment, :post_image , :schedule_id)
  end

end
