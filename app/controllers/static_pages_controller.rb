class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    if logged_in?
    @user = User.find(params[:id])
    @point = Point.find_by(id: params[:user_id])
    @post = Post.find_by(params[:id])
    @posts  = current_user.posts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    @dares = @user.dare_feed.order('created_at DESC')
    @comment = Comment.new
    @comments = @post.comment_feed.order('created_at DESC')
  end
  end
  def user
  end
  def about
  end
  def disclaimer
  end
end