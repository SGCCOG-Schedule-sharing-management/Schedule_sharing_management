class Public::HomesController < ApplicationController
  def guest_sign_in
    user = User.find_or_create_by!(email: 'sample@com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def after_sign_in_path_for(resource)
    new_user_session_path
  end
end