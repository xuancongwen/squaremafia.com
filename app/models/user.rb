class User < ActiveRecord::Base
  has_secure_password
  has_many :mailing_lists, through: :mailing_list_subscriptions
  has_many :mailing_list_subscriptions

  phony_normalize :phone, default_country_code: 'US'
  validates_plausible_phone :phone, normalized_country_code: 'US'
end