class Admin::GroupsController < ApplicationController
  
  def new
    @newgroup = Group.new
  end 
  
  def create
    @newgroup = Group.new(group_params)
    @newgroup.save!
    if @newgroup.save
      flash[:notice] = "新しいグループを作成しました"
      redirect_to admin_group_path(@newgroup)
    else
      flash[:notice] = "新しいグループを作成できませんでした"
      @group = Group.all
      render :new
    end
  end 
  
  def show
    @group = Group.find(params[:id])
  end 
  
  
  def index
  end 
  
  def edit
  end 
  
  def update
  end 
  
  def destroy
  end 
 private
  # ストロングパラメータ
  def group_params
    params.require(:group).permit(:title, :content, :actual_date, :production_location)
  end   
  
end
