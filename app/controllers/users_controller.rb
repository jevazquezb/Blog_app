class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  # load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
