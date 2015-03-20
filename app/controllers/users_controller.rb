class UsersController < ApplicationController

    before_action :logged_in_user, only: [:edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
 # scope :ordered_by_point_count, -> { joins(:point).order('points.count') }

  #example of how will paginate works, also view for
   def index
    @dares = Dare.find_by(params[:id])
        if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.paginate(page: params[:page])
  end
  end
  def dared
    @user = User.find(params[:id])
    @won_feed_items = @user.won_feed.paginate(page: params[:page])
    @dares = @won_feed_items.paginate(page: params[:page])
    @vote = Vote.new
  end

  def new
    @user = User.new
  end
  def view
  @user = User.find(params[:id])
  @issued_feed_items = @user.issued_feed.paginate(page: params[:page])
  @dares = @issued_feed_items
  

  end
  def rank
    @user = User.find_by(params[:id])
    @rankers = User.joins(:points).group("points.user_id").order("count(points.user_id) desc")

    @users = User.paginate(page: params[:page]) 
    @dares = User.includes(:dares)
   @dares = Dare.where(:recipient_id => :id)
  end
  def points
  @rankers = User.top_points.uniq
 @users = User.paginate(page: params[:page])
  end
  def dares
    @users = User.joins(:dares).group("dares.won_id").order("count(dares.won_id) desc").paginate(page: params[:page]).uniq
  end
    def lostest
    @users = User.joins(:dares).group("dares.lost_id").order("count(dares.lost_id) desc").paginate(page: params[:page]).uniq
  end
  def lost
    @user = User.find(params[:id])
    @lost_feed_items = @user.lost_feed.paginate(page: params[:page])
    @dares = @lost_feed_items
    @vote = Vote.new
  end
  def issued
    @users = User.joins(:dares).group("dares.issued_id").order("count(dares.issued_id) desc").paginate(page: params[:page]).uniq
  end
    def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = User.includes(:points).order("points.total")
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = User.includes(:points).order("points.total")
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def show
    @user = User.find(params[:id])
   @comments = Comment.new
    @dare = Dare.new
    @feed_items = @user.posts.paginate(page: params[:page])
    @posts = @feed_items
    @dare_feed_items = @user.dare_feed.paginate(page: params[:page])
    @dares = @dare_feed_items.paginate(page: params[:page])
    @vote = Vote.new
  end
   def home
    if logged_in?
    @user = User.find(params[:id])
   @feed_items = @user.feed.paginate(page: params[:page])
   @point = @user.points.count
   @posts  = current_user.posts.build
    @dare = @user.dare_feed.paginate(page: params[:page])
 end
  end
  
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      	log_in @user
    	flash[:success] = "Welcome #{@user.name}!"
      redirect_to static_pages_rules_path
    else
      render 'new'
    end
  end
    def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :bet, :position,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
