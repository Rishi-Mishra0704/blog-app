class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.recent_three_posts
  end
end
