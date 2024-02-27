class Admin::GroupParticipationApplicationsController < ApplicationController
  def index
    #@requests_all = GroupParticipationApplication.all
    @requests_all = GroupParticipationApplication.all.sort_by(&:created_at).reverse
  end 
  
  def show
    @application = GroupParticipationApplication.find(params[:id])
  end 
  
def update
  @application = GroupParticipationApplication.find(params[:id])

  # ラジオボタンが選択されているかどうかを確認
  if params.dig(:group_participation_application, :application_status).blank?
    flash.now[:notice] = '申請ステータスに🔘チェックを入れてから、[ステータス変更]ボタンを押してください'
    render :show
    return
  end


  if @application.update(application_params)
    flash[:success] = 'ステータスが更新されました'
    redirect_to admin_group_participation_applications_path
  else
    flash.now[:error] = 'ステータスの更新に失敗しました'
    render :show
  end
end

  
  
  
  
  
  private

  def application_params
    params.require(:group_participation_application).permit(:application_status)
        .transform_values { |value| value.to_i }
  end
end
