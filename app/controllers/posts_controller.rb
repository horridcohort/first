class PostsController < ApplicationController
 # before_action :logged_in_user, only: [:create, :destroy]
 # before_action :correct_user,   only: :destroy
  def new
  @posts = Post.new(post_params)
  @points = Point.new
  end
  def create
 @posts = current_user.posts.build(post_params)
      if @posts.save
    user = @posts.user
    user.points.create
      flash[:success] = "Post created!"
      redirect_to home_user_path(current_user)
    else
      redirect_to :back
      flash[:error] = "Post not saved"
    end
  end
  def upvote
  @post = Post.find(params[:id])
  @post.liked_by current_user
#  upvote.save
  redirect_to(:back)
end
def downvote
  @post = Post.find(params[:id])
  @post.downvote_from current_user
 # downvote.save
  redirect_to(:back)
end
   def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  def comments
        @comments = current_user.comments.create(comment_params)
  if @comments.save
    user = @comments.user
    user.points.create
    redirect_to :back
    flash[:success] = "Comment posted"
  else
    flash.now[:danger] = "error"
  end
end
def show
     @post = Post.find(params[:id])
   @comments = @post.comments.new
  end
  private
    def post_params
      params.require(:post).permit(:content, :user_id)
    end
    def point_params
       params.require(:point).permit(:user_id, :bet) 
    end
        def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id, :name)
    end
         def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end