class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :mentor_mailing]

  def index
    mentors = User.with_role :mentor
    mentors_with_avatar = mentors.reject { |x| x.avatar.blank? }
    @users = mentors_with_avatar.shuffle
  end

  def user_index
  	if current_user.nil? || ((current_user.has_role? :admin) == false)
  		flash[:success] = "You do not have access to this page"
  		redirect_to root_url
  	elsif current_user.has_role? :admin
  		@users = User.order('id ASC')
  	end
  end

  def user_mentor
  	if current_user.nil? || ((current_user.has_role? :admin) == false)
  		flash[:success] = "You do not have access to this page"
  		redirect_to root_url
  	elsif current_user.has_role? :admin
  		user = User.find_by_id!(params[:id])
  		if user.has_role? :mentor
  			user.remove_role :mentor
  			flash[:success] = "#{user.name} removed of mentor role."
  			redirect_to user_index_path
  		elsif !(user.has_role? :mentor)
  			user.add_role :mentor
  			flash[:success] = "#{user.name} made into mentor."
  			redirect_to user_index_path
  		end
  	end
  end

  def show
  	@confirm = params[:confirmation]
  	@first_hour = params[:first_hour]
  	@commonapp = params[:commonapp]
  	@supplement = params[:supplement]
  	@add_hour = params[:add_hour]
  	@complete = params[:complete]
  	@junior = params[:junior]
  	@user = User.find_by_slug!(params[:slug])
  end

  def mentor_mailing
  	@user = current_user
  	if ChatLimit.find_by_email(@user.email).blank?
	  	@mentor = User.find_by_slug(params[:slug])
	  	MentorMailer.freechat_email(@user, @mentor).deliver
	  	MentorMailer.freechat_email_student(@user, @mentor).deliver
	  	flash[:success] = "Email successfully sent!"
	  	ChatLimit.create(email: @user.email, chattimes: 1, chatstamp: Time.now)
	  	puts "HEREHERERERER"
	  	p ChatLimit.find_by_email(@user.email).chattimes
	  	p ChatLimit.find_by_email(@user.email).chatstamp
	  	redirect_to root_url
	elsif ChatLimit.find_by_email(@user.email).chattimes < 4
		@mentor = User.find_by_slug(params[:slug])
	  	MentorMailer.freechat_email(@user, @mentor).deliver
	  	MentorMailer.freechat_email_student(@user, @mentor).deliver
	  	flash[:success] = "Email successfully sent!"
	  	@chat = ChatLimit.find_by_email(@user.email)
	  	@chat.chattimes += 1
	  	@chat.save
	  	redirect_to root_url
	elsif ChatLimit.find_by_email(@user.email).chattimes = 4
		@chat = ChatLimit.find_by_email(@user.email)
		if (Time.now - @chat.chatstamp) / 604800 > 1
			@mentor = User.find_by_slug(params[:slug])
		  	MentorMailer.freechat_email(@user, @mentor).deliver
		  	MentorMailer.freechat_email_student(@user, @mentor).deliver
		  	flash[:success] = "Email successfully sent!"
		  	@chat.chattimes = 1
		  	@chat.chatstamp = Time.now
		  	@chat.save
		  	redirect_to root_url
		else
			flash[:success] = "You have reached your weekly limit of 4 requests to chat. Please check back in a week to request additional chats."
			redirect_to root_url
		end
	end
  end

  def express_order
  	@student = current_user
  	@package = params[:package]
  	@mentor = User.find_by_slug(params[:slug])
  	if @package == 'first hour'
	  	response = EXPRESS_GATEWAY.setup_purchase(4000,
	      :ip => request.remote_ip,
	      :return_url => "http://www.ivyrocket.com/#{orders_path}",
	      :cancel_return_url => "http://www.ivyrocket.com",
	      :subtotal => 4000,
	      :shipping => 0,
	      :handling => 0,
	      :tax =>      0,
	      :items => [{ :name => "#{@mentor.name} | First Hour | #{@student.name}",
	                  :quantity => 1,
	                  :amount   => 4000,
	                  :description => "First hour with #{@mentor.name}"}]
		)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
	elsif @package == 'commonapp'
		mentor_array = @student.orders.map{|x| x[:mentor_id]}
		if mentor_array.include? @mentor.id
			response = EXPRESS_GATEWAY.setup_purchase(9000,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 9000,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | CommonApp | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 9000,
		                  :description => "CommonApp package with #{@mentor.name}"}]
			)
			redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
		else
			flash[:failure] = "You must purchase the First Hour with #{@mentor.name} before you can purchase this package."
			redirect_to root_path
		end
	elsif @package == 'supplement'
		mentor_array = @student.orders.map{|x| x[:mentor_id]}
		if mentor_array.include? @mentor.id
			response = EXPRESS_GATEWAY.setup_purchase(5000,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 5000,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | Supplement | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 5000,
		                  :description => "Supplement package with #{@mentor.name}"}]
			)
			redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
		else
			flash[:failure] = "You must purchase the First Hour with #{@mentor.name} before you can purchase this package."
			redirect_to root_path
		end
	elsif @package == 'add hour'
		mentor_array = @student.orders.map{|x| x[:mentor_id]}
		if mentor_array.include? @mentor.id
			response = EXPRESS_GATEWAY.setup_purchase(2500,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 2500,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | Additional Hour | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 2500,
		                  :description => "Additional hour with #{@mentor.name}"}]
			)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
		else
			flash[:failure] = "You must purchase the First Hour with #{@mentor.name} before you can purchase this package."
			redirect_to root_path
		end
	elsif @package == 'complete'
		response = EXPRESS_GATEWAY.setup_purchase(29999,
	      :ip => request.remote_ip,
	      :return_url => "http://www.ivyrocket.com/#{orders_path}",
	      :cancel_return_url => "http://www.ivyrocket.com",
	      :subtotal => 29999,
	      :shipping => 0,
	      :handling => 0,
	      :tax =>      0,
	      :items => [{ :name => "#{@mentor.name} | Complete Package | #{@student.name}",
	                  :quantity => 1,
	                  :amount   => 29999,
	                  :description => "Complete package with #{@mentor.name}"}]
		)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
	elsif @package == 'junior'
		response = EXPRESS_GATEWAY.setup_purchase(5000,
	      :ip => request.remote_ip,
	      :return_url => "http://www.ivyrocket.com/#{orders_path}",
	      :cancel_return_url => "http://www.ivyrocket.com",
	      :subtotal => 5000,
	      :shipping => 0,
	      :handling => 0,
	      :tax =>      0,
	      :items => [{ :name => "#{@mentor.name} | Junior Package | #{@student.name}",
	                  :quantity => 1,
	                  :amount   => 5000,
	                  :description => "Junior package with #{@mentor.name}"}]
		)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
	end
  end
end