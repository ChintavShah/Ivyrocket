class MentorMailer < ActionMailer::Base
  default from: "admin@ivyrocket.com"

  def freechat_email(student, mentor)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Request for Chat")
  end

  def freechat_email_student(student, mentor)
  	@student = student
  	@mentor = mentor
  	mail(to: "#{student.name} <#{student.email}>", subject: "[IvyRocket] Request for 20 Minute Consultation")
  end

  def ivyrocketchat_email(student)
    @student = student
    mail(to: ["#{student.name} <#{student.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Free Consultation with the IvyRocket Team")
  end

  def first_hour_purchase_email(mentor, student)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] First Hour Purchase")
  end

  def commonapp_purchase_email(mentor, student)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] CommonApp Package Purchase")
  end

  def supplement_purchase_email(mentor, student)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Supplement Package Purchase")
  end

  def additional_hour_purchase_email(mentor, student)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Additional Hour Purchase")
  end

  def complete_purchase_email(mentor, student)
  	@student = student
  	@mentor = mentor
  	mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Complete Package Purchase")
  end

  def junior_purchase_email(mentor, student)
    @student = student
    @mentor = mentor
    mail(to: ["#{mentor.name} <#{mentor.email}>", "theivyrocket@gmail.com"], subject: "[IvyRocket] Junior Package Purchase")
  end
end
