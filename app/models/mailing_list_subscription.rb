class MailingListSubscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :mailing_list
end