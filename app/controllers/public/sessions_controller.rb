# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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
    user = User.find_by(nickname: user_params[:nickname])

    if user && user.valid_password?(user_params[:password])
      sign_in(user)
      redirect_to root_path, notice: 'ログインに成功しました。'
    else
      flash.now[:alert] = 'ログインに失敗しました。'
      render :new
    end
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

  def user_params
    params.require(:user).permit(:nickname, :password, :remember_me)
  end

end

