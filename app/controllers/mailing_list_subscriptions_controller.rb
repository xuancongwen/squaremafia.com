class MailingListSubscriptionsController < ApplicationController
  before_filter :require_login

  def index
    @all_lists = MailingList.all.order(:name)
    @subscribed_lists = current_user.mailing_lists
  end

  def new
    MailingListSubscription.create!(user: current_user, mailing_list: MailingList.find(params.require(:list_id)))
    flash[:success] = 'Subscribed!'
    redirect_to :back
  end

  def destroy
    current_user.mailing_lists.delete(MailingList.find(params.require(:list_id)))
    flash[:success] = 'Unsubscribed!'
    redirect_to :back
  end
end