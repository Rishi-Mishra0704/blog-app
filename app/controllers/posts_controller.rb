class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end

  def new
    @user = @current_user
    @post = Post.new
  end

  def create
    @user = @current_user
    @post = Post.new(author_id: @user, title: params[:post][:title], text: params[:post][:text])
    @post.author_id = @user.id
    @post.save
    redirect_to user_posts_path(@user)
  end
end
