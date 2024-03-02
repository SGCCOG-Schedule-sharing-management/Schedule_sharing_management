class Admin::SchedulesController < ApplicationController
  def new
    @groups = Group.all
    @newschedule = Schedule.new
  end

  def create
    @newschedule = Schedule.new(schedule_params)
    @newschedule.group_id = params[:schedule][:group_id]
  
    if @newschedule.save
      flash[:success] = "新しいスケジュールを作成しました"
      redirect_to admin_schedules_path
    else
      flash[:error] = "新しいスケジュールを作成できませんでした"
      render :new
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    #@schedule_participant = ScheduleParticipant.find_by(id: params[:id])
    #@schedule_participants = @schedule.schedule_participants.where(attendance_status: ['joining'])
    @schedule_participants = @schedule.schedule_participants.where(attendance_status: 'joining')
    if @schedule.nil?
      flash[:notice] = "この日の予定はありません"
    end
  end

  def index
    @schedules = Schedule.all
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = "スケジュールの内容を更新しました"
      redirect_to admin_schedule_path(@schedule)
    else
      flash[:error] = "スケジュールの内容を更新できませんでした"
      @schedule = Schedule.all
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    if @schedule.destroy
      flash[:success] = "スケジュールを削除しました"
      redirect_to admin_schedules_path
    else
      flash[:error] = "スケジュールを削除できませんでした"
      @schedule = Schedule.all
      render :show
    end
  end
  
  private

def schedule_params
  params.require(:schedule).permit(:group_id, :start_time, :start, :end, :location, :content, :other_attribute, :classification).tap do |whitelisted|
    whitelisted[:classification] = whitelisted[:classification].to_i
end
end



end
