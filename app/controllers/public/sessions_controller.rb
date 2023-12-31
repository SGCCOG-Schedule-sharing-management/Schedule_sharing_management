# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  before_action :set_authentication_keys

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
  
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
private

# アクティブであるかを判断するメソッド
def user_state
  # 【処理内容1】 入力されたニックネームからアカウントを1件取得
  user = User.find_by(nickname: params[:user][:nickname])
  # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
  return if user.nil?
  # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
  return unless user.valid_password?(params[:user][:password])

  # 【処理内容4】 アクティブでない会員に対する処理
  if user.is_active == true
    # アクティブな場合の処理
    def create
       super
    end
  else
    # アクティブでない場合の処理
    flash[:notice] = "退会済みです。再度登録をするか管理者にお問い合わせください。"
    redirect_to new_user_registration_path
  end
end


  def set_authentication_keys
    request.env["devise.mapping"] = Devise.mappings[:user]
    Devise.setup do |config|
      config.authentication_keys = [:nickname]
    end
  end

def user_params
  params.require(:user).permit(:nickname, :password)
end

end