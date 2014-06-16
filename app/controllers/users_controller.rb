class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :mentor_mailing]

  def index
    @users = User.with_role :mentor
  end

  def show
  	@confirm = params[:confirmation]
  	@first_hour = params[:first_hour]
  	@commonapp = params[:commonapp]
  	@supplement = params[:supplement]
  	@add_hour = params[:add_hour]
  	@complete = params[:complete]
  	@user = User.find_by_slug!(params[:slug])
  end

  def mentor_mailing
  	@user = current_user
  	@mentor = User.find_by_slug(params[:slug])
  	MentorMailer.freechat_email(@user, @mentor).deliver
  	MentorMailer.freechat_email_student(@user, @mentor).deliver
  	flash[:success] = "Email successfully sent!"
  	redirect_to root_url
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
			response = EXPRESS_GATEWAY.setup_purchase(6000,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 6000,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | CommonApp | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 6000,
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
			response = EXPRESS_GATEWAY.setup_purchase(4000,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 4000,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | Supplement | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 4000,
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
			response = EXPRESS_GATEWAY.setup_purchase(1800,
		      :ip => request.remote_ip,
		      :return_url => "http://www.ivyrocket.com/#{orders_path}",
		      :cancel_return_url => "http://www.ivyrocket.com",
		      :subtotal => 1800,
		      :shipping => 0,
		      :handling => 0,
		      :tax =>      0,
		      :items => [{ :name => "#{@mentor.name} | Additional Hour | #{@student.name}",
		                  :quantity => 1,
		                  :amount   => 1800,
		                  :description => "Additional hour with #{@mentor.name}"}]
			)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
		else
			flash[:failure] = "You must purchase the First Hour with #{@mentor.name} before you can purchase this package."
			redirect_to root_path
		end
	elsif @package == 'complete'
		response = EXPRESS_GATEWAY.setup_purchase(20000,
	      :ip => request.remote_ip,
	      :return_url => "http://www.ivyrocket.com/#{orders_path}",
	      :cancel_return_url => "http://www.ivyrocket.com",
	      :subtotal => 20000,
	      :shipping => 0,
	      :handling => 0,
	      :tax =>      0,
	      :items => [{ :name => "#{@mentor.name} | Complete Package | #{@student.name}",
	                  :quantity => 1,
	                  :amount   => 20000,
	                  :description => "Complete package with #{@mentor.name}"}]
		)
		redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
	end
  end
end