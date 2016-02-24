class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create]

  def index
    @users = User.all.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation))
    if verify_recaptcha(model: @user) && @user.save
      flash[:success] = 'Success! You will be notified when approved.'
      redirect_to(:root)
    else
      render :new
    end
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
    @user = current_user
    p = params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
    old_mail = @user.email
    @user.update_attributes(p)
    MailmanSyncJob.perform_later if p['email'] != old_mail
    flash.now[:success] = 'Your profile has been updated.' unless @user.errors.any?
    render :edit
  end
end