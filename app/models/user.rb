# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :trackable, # :registerable,
          :rememberable, :validatable,  # :recoverable, # need to configure ability to send emails first
          authentication_keys: [:login] # , :email, :username]

  validates :real_name,   presence: true
  validates :email,       presence: true, uniqueness: true,
                          format: { with: Devise.email_regexp }
  validates :username,    presence: true,
                          uniqueness: { case_sensitive: false },
                          format: { with: /\A[a-z0-9_\-]*\z/,
                                    message: 'only lowercase letters, numbers, underscores and dashes allowed' }
  validates :password,    presence: true, on: :create
  validates :access_role, presence: true,
                          inclusion: { in: ApplicationHelper::VALID_ROLES }

  validate  :validate_password_complexity

  # for mailer
  def display_name
    real_name.blank? ? username : email
  end

  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_writer :login

  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def login
    @login || username || email
    # @login || self.username || self.email
  end

  # allow token based user_authentication!
  def password_required?
    false # because we aren't using passwords
  end

  # https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase.strip }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      conditions[:email]&.downcase!&.strip!
      conditions[:username]&.downcase!&.strip!
      where(conditions.to_h).first
    end
  end

  private

  # https://github.com/heartcombo/devise/wiki/How-To:-Set-up-simple-password-complexity-requirements
  def validate_password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z]).{9,70}$/

    errors.add :password,
               'Complexity requirement not met. Length should be 9-70 characters long and includes: 1 uppercase and 1 lowercase.'
  end
end
