class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    if @users.any?
      render json: @users
    else
      render json: { errors: 'No users found' }, status: :not_found
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end
