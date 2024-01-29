class Public::GroupParticipationApplicationsController < ApplicationController
  def new
    @group = Group.find_by(id: params[:group_id])
 #     if @group.present?
#        @request = GroupParticipationApplication.new
 #     else
  #      flash[:error] = '指定されたグループが見つかりません'
  #      redirect_to groups_path 
  #    end
    @request = GroupParticipationApplication.new
  end 
  
def create
  @user = current_user
  @group = Group.find(params[:group_participation_application][:group_id])
  @request = GroupParticipationApplication.new(request_params)
  @request.user_id = @user.id
  @request.group_id = @group.id

  if @request.save!
    flash[:notice] = "申請しました"
    redirect_to groups_path
  else
    flash[:notice] = "申請できませんでした"
    render :new
  end
end
  
  def show
    @group_status = GroupParticipationApplication.find(params[:id])
  end 
  
    # ストロングパラメータ
  def request_params
    params.require(:group_participation_application).permit(:title, :comment, :group_id)
  end
  
end
