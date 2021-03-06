class MailingList < ActiveRecord::Base
  has_many :users, through: :mailing_list_subscriptions
  has_many :mailing_list_subscriptions

  def group_email
    "#{name}@squaremafia.com"
  end
end