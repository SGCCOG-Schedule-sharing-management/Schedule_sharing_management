class Public::AchievementsController < ApplicationController
  def new
    @schedule = Schedule.find(params[:schedule_id])
    @schedule_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @achievement = Achievement.new
  end



def create
  # byebug
  @schedule = Schedule.find(params[:schedule_id])
  @achievement = Achievement.new(achievement_params)
  @achievement.schedule = @schedule

  # Scheduleのスケジュール参加者を取得
  @schedule_participants = @schedule.schedule_participants.where(attendance_status: 'joining')

  selected_nicknames = params[:participants] || [] # チェックされたニックネームの配列を取得

  selected_users = User.where(nickname: selected_nicknames) # チェックされたニックネームに対応するユーザーを取得
  participant_names = selected_users.map(&:nickname).join(', ') # 選択されたユーザーのニックネームを保存

  @achievement.participant = participant_names # @achievementのparticipantを設定
  @achievement.user = current_user
  #byebug
  if @achievement.save
    flash[:success] = "活動報告を投稿しました"
    redirect_to achievement_path(@achievement)
  else
    flash[:error] = "活動報告の投稿に失敗しました"
    puts @achievement.errors.full_messages.join(', ')
    render :new
  end
end

  def show
    @achievement = Achievement.find(params[:id])
    @achievement_comment = AchievementComment.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    
    if @achievement.update(achievement_params)
      flash[:success] = "活動報告を修正しました"
      redirect_to achievement_path(@achievement)
    else
      flash[:error] = "活動報告を修正できませんでした"
      render :edit
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @schedule = Schedule.find(@achievement.schedule_id) # 関連付けられているスケジュールのIDを使用してスケジュールを検索する
    if @achievement.destroy
      flash[:success] = "投稿を削除しました"
      redirect_to schedule_path(@schedule)
    else
      flash[:error] = "投稿の削除に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end


  private
  def achievement_params
   #params.require(:achievement).permit(:title, :participant, :content, :comment, :post_image)
    params.require(:achievement).permit(:title, :participant, :content, :comment, :post_image , :schedule_id)
  end

end
