class Admin::GroupsController < ApplicationController

  def new
    @newgroup = Group.new
  end

  def create
    @newgroup = Group.new(group_params)
    if @newgroup.save!
      flash[:success] = "新しいグループを作成しました"
      redirect_to admin_group_path(@newgroup)
    else
      flash[:error] = "新しいグループを作成できませんでした"
      @group = Group.all
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @participation_applications = GroupParticipationApplication.where(group_id: @group.id)
  end



  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:success] = "グループの内容を更新しました"
      redirect_to admin_group_path(@group)
    else
      flash[:error] = "グループの内容を更新できませんでした"
      @group = Group.all
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:success] = "グループを削除しました"
      redirect_to admin_groups_path
    else
      flash[:error] = "グループを削除できませんでした"
      @group = Group.all
      render :show
    end
  end
 private
  # ストロングパラメータ
  def group_params
    params.require(:group).permit(:title, :content, :actual_date, :production_location, :group_image)
  end

end
