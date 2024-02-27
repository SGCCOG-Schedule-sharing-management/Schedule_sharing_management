class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      new_admin_session_path
    when User
      mypage_path
    else
      new_user_session_path
    end
  end
end
