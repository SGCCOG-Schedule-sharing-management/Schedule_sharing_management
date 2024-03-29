class Admin::UsersController < ApplicationController
  def index
    @users = User.where.not(last_name: "guest")
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # ラジオボタンが選択されているかどうかを確認
    if params.dig(:user, :is_active).blank?
      flash.now[:notice] = '会員ステータスに🔘チェックを入れてから、[会員ステータスを更新する]ボタンを押してください'
      render :show
      return
    end

    if @user.update(user_params)
      flash[:success] = "グループの内容を更新しました"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "グループの内容を更新できませんでした"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to admin_users_path
    else
      flash[:error] = "ユーザーを削除できませんでした"
      @user = User.all
      render :index
    end
  end

   private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:is_active)
  end

end
