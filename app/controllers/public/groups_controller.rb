class Public::GroupsController < ApplicationController
  def index
    @groups = Group.all
    @group_status = GroupParticipationApplication.find_by(group_id: params[:id])
  end 
  
  def show
    @group = Group.find(params[:id])
    group_participation_application_id = params[:group_participation_application_id]
    @group_status = group_participation_application_id.present? ? GroupParticipationApplication.find(group_participation_application_id) : nil
    #redirect_to new_group_participation_application_path(group_id: @group.id) unless group_participation_application_id.present?
  end
end
