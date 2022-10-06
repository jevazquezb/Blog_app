class Api::V1::CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = Comment.new(comments_params) # 2.- Create a new comment object based on the form data
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    if @comment.save # 3.- Save the comment object to the database.
      # redirect_to user_post_url(@comment.author_id, @comment.post_id)
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # 1.- Retrieves the form data for a comment from the params hash
  def comments_params
    params.permit(:text)
  end

  private :comments_params
end
