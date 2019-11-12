class PostsController < ApplicationController
  before :logged_in_user, only: [:new, :create]

  def index; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to @post
    else
      render 'new'
    end
  end

  private

  # before methods
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
