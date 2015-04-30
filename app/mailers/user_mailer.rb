class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def deleted_email(user)
    @user = user
    mail(to: @user.email, subject: 'We have deleted your account')
  end
end
