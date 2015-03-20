class CommentsController < ApplicationController
  def new
  @comment = Comment.new
  end
  def create
    @post = Post.find(params[:id])
     @comment = Comment.new
    @comment = @post.comments.create(comment_params)
  if @comment.save
    user = @comment.user
    user.points.create #unless user.comments.today.count >= 50
    redirect_to :back
    flash[:success] = "Comment posted"
  else
    redirect_to :back 
    flash[:danger] = "Comment Not Posted"
  end
end
   def destroy
    @comment.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id, :name)
    end
         def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end