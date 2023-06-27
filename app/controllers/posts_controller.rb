class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @author_id = params[:author_id]
    @posts = Post.where(author_id: @author_id)
    @comments = Comment.all
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end
end