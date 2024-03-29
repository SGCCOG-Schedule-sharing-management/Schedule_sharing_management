class Public::SchedulesController < ApplicationController

  def index
    # カレントユーザーが参加しているグループのIDを取得
    user_group_ids = GroupParticipationApplication.where(user_id: current_user.id, application_status: 'approved').pluck(:group_id)

    # カレントユーザーが参加しているグループのスケジュールを取得
    @schedules = Schedule.where(group_id: user_group_ids)
  end

  def show
    @schedule = Schedule.find(params[:id])
    #@schedule_participant = ScheduleParticipant.find_by(schedule_id: @schedule.id, user_id: current_user.id)
    #@schedule_participant = @schedule.schedule_participants.find_by(user_id: current_user.id)
    # デバッグログの出力
    Rails.logger.info("Debug: #{@schedule_participant.inspect}")
    @schedule_participant = ScheduleParticipant.find_by(schedule_id: params[:id], user_id: current_user.id)
    @planned_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @achievements = Achievement.where(schedule_id: [@schedule])

  end

end
