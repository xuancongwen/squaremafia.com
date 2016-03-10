class UserMailer < ApplicationMailer
  def join_email(user)
    @user = user
    mail(to: @user.email, bcc: 'admin@squaremafia.com', subject: 'SquareMafia: Your Account is Pending')
  end

  def approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'SquareMafia: Your Account is Approved')
  end
end
