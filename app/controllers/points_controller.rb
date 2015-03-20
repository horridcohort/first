class PointsController < ApplicationController
	before_action :find_user
  def default
  end
  def new
    @point = Point.new
  end
  def create
    @user = User.find_by(params[:id])
    @point = Point.new(point_params)
  	@point = Point.create.times(:bet)
  end
def destroy
end
  private
  def find_user
     User.find_by(params[:id])
   end
   def point_params
    params.require(:point).permit(:user_id, :bet)
   end
end