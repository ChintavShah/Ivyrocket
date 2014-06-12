class User < ActiveRecord::Base
  rolify
  before_create :set_default_role
  before_save do
    self.slug = name.parameterize
  end
  mount_uploader :avatar, AvatarUploader
  #validates_presence_of :avatar
  validates_presence_of :name, 
    		:bio,
    		:school_name,
    		:degree_year,
    		:hometown,
    		:field_of_study,
    		:major,
    		:applied_early,
    		:SAT_total,
    		:class_rank,
    		:main_high_school_awards,
    		:main_extracurricular_activities,
    		:my_strengths,
    		:my_weaknesses,
    		:why_i_think_i_was_accepted,
    		:biggest_piece_of_advice_to_high_school_students, :if => :user_is_mentor


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  def user_is_mentor
    self.has_role? :mentor
  end

  def to_param
    slug
  end

  private
	  def set_default_role
	    self.add_role :student
	  end

end
