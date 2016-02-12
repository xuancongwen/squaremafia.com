
class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create]

  def index
    @users = User.all.order(:name)
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(params.require(:id))
  end

  def edit
    if params.require(:id).to_i != current_user.id
      flash[:error] = 'You can only edit your own profile.'
      redirect_to :root
    else
      @user = current_user
    end
  end

  def update
    begin
      p = params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
      current_user.update_attributes!(p)
      flash[:success] = 'Your profile has been updated.'
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
    end
    redirect_to :back
  end
end