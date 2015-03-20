class DaresController < ApplicationController
 #  before_action :find_user
 # before_filter :current_user
  before_action :logged_in_user, only: [:create, :destroy]
  def new
    @vote = Vote.new(vote_params)
    @post = Post.find_by(params[:post_id])
  end
  def index
  @dares = @user.dare_feed.paginate(page: params[:page])
  @dare_feed_items = @user.dare_feed.paginate(page: params[:page])
  end
 def show
 end
  def create
    @user = User.find(params[:id])
    @dare = Dare.new(dare_params)
if @dare.bet.nil? || @dare.bet <= -1 
  redirect_to :back
   flash[:error] = "Bet can't be empty or negitive"
   elsif  current_user.points_count >= @dare.bet &&
    @user.points_count >= @dare.bet 
     @dare.save
   redirect_to :back
    flash[:success] = "Your dare was sent"
  else
   redirect_to :back
    flash[:error] = "Your dare was not sent"
  end
end
def update
  @dare = Dare.find(params[:id])
  @dare.accept
  @dare.update
  redirect_to :back
end
   def destroy
    @dare = Dare.find(params[:id])
    @dare.destroy
    redirect_to :back
    flash[:success] = "Dare declined"
   end
private
  def current_user
     @current_user ||= User.find_by(id: session[:user_id])
   end
  def dare_params
    params.require(:dare).permit(:bet, :sender_id, :recipient_id, :body, :user_id, :won_id, :lost_id, :issued_id)
  end
  def vote_params
    params.require(:vote).permit(:value, :dare_id, :user_id)
  end
  def find_user
    User.find(params[:id])
  end
end