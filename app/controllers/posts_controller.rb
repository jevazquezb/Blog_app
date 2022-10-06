class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create delete]

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params) # 2.- Create a new Post object based on the form data
    @post.author = current_user

    if @post.save # 3.- Save the Post object to the database.
      redirect_to user_post_url(@post.author_id, @post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    authorize! :destroy, @post # User's authorization to destroy
    @user = User.find(params[:user_id])
    flash[:notice] = 'Post was deleted'
    redirect_to user_posts_path(@user.id)
  end

  # 1.- Retrieves the form data for a post from the params hash
  def posts_params
    params.require(:post).permit(:title, :text)
  end

  private :posts_params
end
