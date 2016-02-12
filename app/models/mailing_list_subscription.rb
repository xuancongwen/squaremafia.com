class MailingListSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  after_save :enqueue_sync_job
  after_destroy :enqueue_sync_job

  private
  def enqueue_sync_job
    MailmanSyncJob.perform_later(mailing_list.name)
  end
end