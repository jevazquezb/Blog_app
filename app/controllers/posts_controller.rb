class PostsController < ApplicationController
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

  def posts_params # 1.- Retrieves the form data for a post from the params hash
    params.require(:post).permit(:title, :text)
  end

  private :posts_params
end
