class UserController < ApplicationController
  def login
  end

  def login_form
    email = params.require(:email)
    password = params.require(:password)

    user = User.find_by(email: email).try(:authenticate, password)
    if user.present?
      session[:user_id] = user.id
      redirect_to :root
    else
      flash.now[:error] = 'Bad username or password.'
      render :login
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  def create
    # TODO
  end
end