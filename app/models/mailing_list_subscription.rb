class MailingListSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  after_commit { MailmanSyncJob.perform_later }
end