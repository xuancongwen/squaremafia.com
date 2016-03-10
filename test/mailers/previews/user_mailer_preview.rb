# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def join
    UserMailer.join_email(User.first)
  end

  def approval
    UserMailer.approval_email(User.first)
  end
end
