class MailingListSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list

  after_save :add_to_mailman
  after_destroy :remove_from_mailman

  private
  def add_to_mailman
    if Rails.env.production?
      mailman_list.approved_add_member(user.email)
    else
      Rails.logger.warn "Skipping mailman call because we're not in production"
    end
  end

  def remove_from_mailman
    if Rails.env.production?
      begin
        mailman_list.approved_delete_member(user.email)
      rescue MailManager::MailmanExecuteError => e # ignore failure if they weren't a member anyway
        return if e.message =~ /Mailman.Errors.NotAMemberError/
        raise e
      end
    else
      Rails.logger.warn "Skipping mailman call because we're not in production"
    end
  end

  def mailman_list
    @mailman_list ||= mailmanager.get_list(mailing_list.name)
  end

  def mailmanager
    @mailmanager ||= MailManager.init('/usr/lib/mailman')
  end
end