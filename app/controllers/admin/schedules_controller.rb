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
    if @schedule.nil?
      flash[:notice] = "この日の予定はありません"
    end
  end

  def index
    @schedules = Schedule.all
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  # 例
def schedule_params
  params.require(:schedule).permit(:group_id, :start_time, :other_attribute, :classification).tap do |whitelisted|
    whitelisted[:classification] = whitelisted[:classification].to_i
end
end



end
