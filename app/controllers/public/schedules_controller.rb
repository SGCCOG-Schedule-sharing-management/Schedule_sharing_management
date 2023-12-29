class Public::SchedulesController < ApplicationController
# 例: ApplicationController もしくは適切な場所でのコントローラーのアクション内

  def index
    # カレントユーザーが参加しているグループのIDを取得
    user_group_ids = GroupParticipationApplication.where(user_id: current_user.id, application_status: 'approved').pluck(:group_id)
  
    # カレントユーザーが参加しているグループのスケジュールを取得
    @schedules = Schedule.where(group_id: user_group_ids)
  end
  
  def show
    @schedule = Schedule.find(params[:id])
    @schedule_participant = ScheduleParticipant.new
  end 

end
