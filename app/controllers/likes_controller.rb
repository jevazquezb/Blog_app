class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    if has_a_like?
      redirect_to user_post_url(@user.id, @post.id)
    else
      @like = Like.new(params.permit(:@user, :@post))
      @like.author = @user
      @like.post = @post
      redirect_to user_post_url(@user.id, @post.id) if @like.save
    end
  end

  def has_a_like?
    Like.where(author_id: @user.id, post_id: @post.id).exists?
  end

  private :has_a_like?
end