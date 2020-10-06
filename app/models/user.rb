class User < ApplicationRecord

  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :trackable, # :registerable,
          :recoverable, :rememberable, :validatable,
          authentication_keys: [:login] #, :email, :username]

  # allows devise to search for user using either username or email address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase.strip }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase!.strip!    if conditions[:email]
      conditions[:username].downcase!.strip! if conditions[:username]
      where(conditions.to_h).first
    end
  end

  # before validation (take first part of email and parameritze for user name)
  validates :password,  presence: true, on: :create
  validates :username,  presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[a-z0-9_\-]*\z/,
                                  message: "only lowercase letters, numbers, underscores and dashes allowed" }
  validates :email,     presence: true, uniqueness: true,
                        format: { with: Devise::email_regexp }
  validate :validate_password_complexity

  def login
    @login || username || email
    # @login || self.username || self.email
  end

  private

  # https://github.com/heartcombo/devise/wiki/How-To:-Set-up-simple-password-complexity-requirements
  def validate_password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    # return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    # errors.add :password, 'Complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'

    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z]).{12,70}$/

    errors.add :password, 'Complexity requirement not met. Length should be 12-70 characters long and includes: 1 uppercase and 1 lowercase.'
  end

end
