class VotesController < ApplicationController
   def new
   	@vote = Vote.new(vote_params)
  end 
  def create
 @dare = Dare.find(params[:id])
 @vote = Vote.create(vote_params)
 @user = User.find(params[:user_id])
  if @vote.save
      @user.points.create
    redirect_to :back, notice: "Thank you for voting."
  else
    redirect_to :back, alert: "Unable to vote, perhaps you already did."
  end
end
  def show
  end
  private
    def vote_params
    params.permit(:vote, :value, :dare_id, :user_id)
  end
end