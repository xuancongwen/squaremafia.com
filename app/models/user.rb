class User < ActiveRecord::Base
  has_secure_password
  has_many :mailing_lists, through: :mailing_list_subscriptions
  has_many :mailing_list_subscriptions
end