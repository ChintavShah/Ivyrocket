class Users::RegistrationsController < Devise::RegistrationsController
=begin
  def new_mentor
  	if current_user.nil?
  		redirect_to root_url
  	end
  	if current_user.has_role? :admin
	  	build_resource({})
	    respond_with self.resource
	else
		redirect_to root_url
	end
  end

  def create_mentor
  	if current_user.nil?
  		redirect_to root_url
  	end
  	if current_user.has_role? :admin

	  	build_resource(sign_up_params)

	    resource_saved = resource.save
	    yield resource if block_given?
	    if resource_saved
	      if resource.active_for_authentication?
	        set_flash_message :notice, :signed_up if is_flashing_format?
	        sign_up(resource_name, resource)
	        respond_with resource, location: after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	        expire_data_after_sign_in!
	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end
	else
		redirect_to root_url
	end
  end
=end


  protected
  	def sign_up_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

  	def account_update_params
    	params.require(:user).permit(:email, :password, :password_confirmation, :current_password,
    		:name, 
    		:bio, 
    		:school_name,
    		:degree_year,
    		:hometown,
    		:field_of_study,
    		:major,
    		:other_acceptances,
    		:other_waitlists,
    		:applied_early,
    		:SAT_total,
    		:SAT_math,
    		:SAT_reading,
    		:SAT_writing,
    		:ACT_composite,
    		:class_rank,
    		:main_high_school_awards,
    		:main_extracurricular_activities,
    		:job_experience,
    		:volunteer_experience,
    		:summer_activities,
    		:my_strengths,
    		:my_weaknesses,
    		:why_i_think_i_was_accepted,
    		:biggest_piece_of_advice_to_high_school_students,
    		:avatar)
  	end

    def after_sign_up_path_for(resource)
      signed_in_root_path(resource)
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end
end