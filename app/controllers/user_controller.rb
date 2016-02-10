class UserController < ApplicationController
  def login
    email = params.require(:email)
    password = params.require(:password)

    user = User.find_by(email: email).try(:authenticate, password)
    if user.present?
      session[:user_id] = user.id
    else
      flash[:error] = 'Bad username or password.'
    end

    redirect_to :root
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  def create
    # TODO
  end
end