class SessionsController < ApplicationController
  before_filter :require_login, only: [:destroy]

  def new
  end

  def create
    email = params.require(:email)
    password = params.require(:password)

    user = User.find_by(email: email).try(:authenticate, password)
    if user.present?
      session[:user_id] = user.id
      redirect_to :root
    else
      flash.now[:error] = 'Bad username or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end