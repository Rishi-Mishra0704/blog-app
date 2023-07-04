class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments, :author).where(author_id: params[:user_id])
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = Post.includes(:comments, :author).find(params[:id])
    @comments = @post.comments
    @like = Like.new
  end

  def new
    @user = @current_user
    @post = Post.new
  end

  def create
    @user = @current_user
    @post = Post.new(post_params)
    @post.author_id = @user.id
    @post.save
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
