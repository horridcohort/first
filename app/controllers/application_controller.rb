class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
helper_method :current_user
include SessionsHelper
include Possessive
  private
  def points_add(dare)
   bet = dare.bet
   user = dare.won_id
  bet.times do |point|
    Point.create!(:user_id => user)
  end
end
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
