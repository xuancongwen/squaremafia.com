class MailingListSubscriptionsController < ApplicationController
  before_filter :require_login

  def index
    @all_lists = MailingList.all.order(:name)
    @subscribed_lists = current_user.mailing_lists
  end

  def new
    list = MailingList.find(params.require(:list_id))
    current_user.mailing_lists << list
    MailmanSyncJob.perform_later(list.name)
    flash[:success] = 'Subscribed!'
    redirect_to :back
  end

  def destroy
    list = MailingList.find(params.require(:list_id))
    current_user.mailing_lists.destroy(list)
    MailmanSyncJob.perform_later(list.name)
    flash[:success] = 'Unsubscribed!'
    redirect_to :back
  end
end