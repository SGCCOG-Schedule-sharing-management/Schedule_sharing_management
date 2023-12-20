class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_user
    if resource.nickname == 'ゲスト'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

  def configure_sign_up_params
    byebug
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end




end
