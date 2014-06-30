class OrdersController < ApplicationController
	def new
		@order = Order.new(:express_token => params[:token])
	end

	def create
		@order = Order.new(:express_token => params[:order][:express_token])
		@order.ip_address = request.remote_ip
		if @order.save
			if @order.purchase
				flash[:success] = "Purchase successful! Thank you so much!"
				information = @order.name.split(" | ")
			  	@mentor = User.find_by_name(information[0])
			  	@package = information[1]
			  	@student = User.find_by_name(information[2])
			  	@order.user_id = current_user.id
			  	@order.mentor_id = @mentor.id
			  	@order.save
			  	if @package == 'First Hour'
			  		MentorMailer.first_hour_purchase_email(@mentor, @student).deliver
			  	elsif @package == 'CommonApp'
			  		MentorMailer.commonapp_purchase_email(@mentor, @student).deliver
			  	elsif @package == 'Supplement'
			  		MentorMailer.supplement_purchase_email(@mentor, @student).deliver
			  	elsif @package == 'Additional Hour'
			  		MentorMailer.additional_hour_purchase_email(@mentor, @student).deliver
			  	elsif @package == 'Complete Package'
			  		MentorMailer.complete_purchase_email(@mentor,@student).deliver
			  	elsif @package == 'Junior Package'
			  		MentorMailer.junior_purchase_email(@mentor,@student).deliver
			  	end
				redirect_to root_path
			else
				flash[:failure] = "Purchase failure."
				redirect_to root_path
			end
		else
			flash[:failure] = "Purchase Failure."
			redirect_to root_path
		end
	end
end