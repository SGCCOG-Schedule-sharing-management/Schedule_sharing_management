class Public::ScheduleParticipantsController < ApplicationController
  def new
    @schedule_participant = ScheduleParticipant.new
    @schedule = Schedule.find_by(id: params[:schedule_id])
    Rails.logger.info("New ScheduleParticipant - Schedule: #{@schedule.inspect}")
  end

  def create
    @user = current_user
    schedule_id = params[:schedule_participant][:schedule_id]
    
    @schedule = Schedule.find(schedule_id)
        # ラジオボタンが選択されているかどうかを確認
    if params.dig(:schedule_participant, :attendance_status).blank?
      flash.now[:notice] = '出欠ステータスに🔘チェックを入れてから、[回答送信]ボタンを押してください'
      render :new
      return
    end
    
    @schedule_participant = ScheduleParticipant.new(schedule_participant_params.merge(user_id: @user.id, schedule_id: @schedule.id, date: @schedule.start_time))

    if @schedule_participant.save
      flash[:success] = "出欠回答を送信しました"
      redirect_to schedule_path(@schedule_participant.schedule)
    else
      flash[:error] = "出欠回答できませんでした"
      redirect_to schedule_path(@schedule_participant.schedule)
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    @schedule_participant = ScheduleParticipant.find_by(id: params[:id])
  end

  def edit
    @schedule_participant = ScheduleParticipant.find_by(id: params[:id])
    Rails.logger.info("Edit ScheduleParticipant - ScheduleParticipant: #{@schedule_participant.inspect}")
  end

def update
  @schedule_participant = ScheduleParticipant.find(params[:id])

  Rails.logger.info("Permitted Params: #{params.require(:schedule_participant).permit(:attendance_status).inspect}")
  Rails.logger.info("Updated ScheduleParticipant: #{schedule_participant_params.inspect}")

  if @schedule_participant.update(schedule_participant_params)
    flash[:success] = "出欠ステータスを変更しました"

    # スケジュール情報のログ出力
    Rails.logger.info("Updated ScheduleParticipant: #{schedule_participant_params.inspect}")
    redirect_to schedule_schedule_participant_path(@schedule_participant.schedule)
  else
    flash[:error] = "出欠ステータスを変更できませんでした"
    redirect_to edit_schedule_schedule_participant_path(@schedule_participant.schedule)
  end
end


  private

  def schedule_participant_params
    params.require(:schedule_participant).permit(:user_id, :schedule_id, :date, :time, :attendance_status)
  end
end
