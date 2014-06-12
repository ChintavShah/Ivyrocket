class UsersController < ApplicationController

  def index
    @users = User.with_role :mentor
  end

  def show
  	@user = User.find_by_slug!(params[:slug])
  end

end