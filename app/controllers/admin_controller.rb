class AdminController < ApplicationController
  before_filter :require_admin

  def approval_queue
    @users = User.where(role: 'queued_for_approval').order(:created_at)
  end

  def change_role
    @user = User.find(params.require(:id).to_i)
    @user.update_attribute(:role, params.require(:new_role))

    flash[:success] = "'#{@user.name}' now has role '#{@user.role}'"
    redirect_to :back
  end
end