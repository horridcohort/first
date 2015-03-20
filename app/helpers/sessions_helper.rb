module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user?(user)
    user == current_user
  end
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
    def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
  # Returns the user corresponding to the remember token cookie.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
  	!current_user.nil?
  end
  # Forgets a persistent session.
  def forget(user)
    #user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end