class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mentor_mailing]

  def index
    @users = User.with_role :mentor
  end

  def show
  	@confirm = params[:confirmation]
  	if @confirm == 'true'
  		:authenticate_user!
  	end
  	@user = User.find_by_slug!(params[:slug])
  end

  def mentor_mailing
  	@user = current_user
  	@mentor = User.find_by_slug(params[:slug])
  	MentorMailer.freechat_email(@user, @mentor).deliver
  	flash[:success] = "Email successfully sent!"
  	redirect_to root_url
  end
end