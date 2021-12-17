class Participant < ApplicationRecord
  before_save :downcase_email

  validates :ip_addr,   presence: true
  validates :email,     presence: true, uniqueness: true,
                        format: { with: Devise::email_regexp }
  validate :validate_ip_address_not_abusive

  # participant viewmodel?
  def display_name
    fullname.blank? ? email : fullname
  end

  # Should token management be a Decorator?
  def valid_token?(date_time)
    date_time < login_token_valid_until
  end

  def expire_token_validity!
    self.token_valid_until = DateTime.now - 1.days
    save!
  end

  def extend_token_validity!(valid_days = 20)
    self.token_valid_until = DateTime.now + (valid_days.to_i).days
    save!
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end

  def validate_ip_address_not_abusive
    return if ip_count_ok?

    errors.add(:email, "Excessive Requests")
  end

  # ensure a given IP isn't creating lots of accounts (DOS attack) in production
  def ip_count_ok?
    return true if Rails.env.test? || Rails.env.development?

    ip_addr_todays_count = Participant.where(ip_addr: ip_addr)
                                      .where(updated_at: DateTime.now)
                                      .count
    ip_addr_todays_count < 5
  end

end
