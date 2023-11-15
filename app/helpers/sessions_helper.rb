module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      redirect_to login_path
    end
  end

  # def require_admin
  #   unless current_user.admin?
  #     error_403
  #   end
  # end

  def error_403
    render inline: "<h1>403 Forbidden</h1>", status: 403
  end
end
