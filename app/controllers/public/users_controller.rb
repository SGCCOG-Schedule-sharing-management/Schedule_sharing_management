class Public::UsersController < ApplicationController
 
  
  def show
    @user = current_user
  end 
  
  def edit
    @user = current_user
  end 
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to mypage_path
    else
      flash.now[:error] = "情報混信できませんでした"
      render :edit
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:first_name,:last_name, :first_name_kana, :last_name_kana, :nickname, :email, :profile_image, :introduction)
  end
 



end
