class UsersController < ApplicationController
  before_filter :require_login, except: [:new]

  # CRUD
  def update
    begin
      p = params.require(:user).permit(:email, :phone, :password, :password_confirmation)
      current_user.update_attributes!(p)
      flash[:success] = 'Your profile has been updated.'
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
    end
    redirect_to :user
  end

  def show
  end

  def new
  end
end