class User < ActiveRecord::Base
  has_secure_password
  has_many :mailing_lists, through: :mailing_list_subscriptions
  has_many :mailing_list_subscriptions

  phony_normalize :phone, default_country_code: 'US'
  validates_plausible_phone :phone, normalized_country_code: 'US'
  validates :email, presence: true, format: /@/

  after_commit :queue_mailman_sync

  private
  def queue_mailman_sync
    return unless email_changed?
    MailmanSyncJob.perform_later
  end
end