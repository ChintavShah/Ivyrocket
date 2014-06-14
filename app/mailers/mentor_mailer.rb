class MentorMailer < ActionMailer::Base
  default from: "admin@ivyrocket.com"

  def freechat_email(student, mentor)
  	@student = student
  	@mentor = mentor
  	mail(to: "#{mentor.name} <#{mentor.email}>", subject: "[IvyRocket] Request for Chat")
  end

  def freechat_email_student(student, mentor)
  	@student = student
  	@mentor = mentor
  	mail(to: "#{student.email}", subject: "[IvyRocket] Request for chat")
  end
end
