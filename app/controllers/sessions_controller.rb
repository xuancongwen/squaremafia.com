class SessionsController < ApplicationController
  before_filter :require_login, only: [:destroy]

  def new
  end

  def create
    email = params.require(:email)
    password = params.require(:password)

    user = User.find_by(email: email).try(:authenticate, password)
    if user.present?
      case user.role
        when 'queued_for_approval'
          flash[:error] = "Account is queued for approval. Contact admin@squaremafia.com if it's been a few days."
        when 'disabled'
          flash[:error] = 'Account disabled. Contact admin@squaremafia.com if you think this is an error.'
        when /admin|regular/
          session[:user_id] = user.id
        else
          raise 'Something went wrong'
      end
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