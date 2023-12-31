class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end 
  
  def show
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "グループの内容を更新しました"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "グループの内容を更新できませんでした"
      render :edit
    end
  end 
  
   private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:is_active)
  end   
  
end
