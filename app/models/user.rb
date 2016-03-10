class User < ActiveRecord::Base
  class TenureValidator < ActiveModel::Validator
    def validate(record)
      return if record.sq_start_date.blank? || record.sq_end_date.blank? #handled by other validation

      if record.sq_start_date > record.sq_end_date
        record.errors[:sq_end_date] << 'Last day must be after first day.'
      end
    end
  end

  has_secure_password
  has_many :mailing_lists, through: :mailing_list_subscriptions
  has_many :mailing_list_subscriptions

  phony_normalize :phone, default_country_code: 'US'
  validates_plausible_phone :phone, normalized_country_code: 'US'
  validates :email, presence: true, format: /@/
  validates :name, presence: true
  validates :sq_start_date, presence: true
  validates :sq_end_date, presence: true
  validates :discipline, presence: true
  validates_with TenureValidator

  enum role: [:queued_for_approval, :regular, :admin, :disabled]

  scope :enabled, -> { where(role: %w(regular admin)) }
end