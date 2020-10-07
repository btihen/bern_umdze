class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :trackable, # :registerable,
          :recoverable, :rememberable, :validatable, 
          authentication_keys: [:login] #, :email, :username]

  attr_writer :login

  # TODOS:
  # validate email
  # validate role in ApplicationHelper::VALID_ROLES
  # before validation (take first part of email and parameritze for user name)
  validates :username,  presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[a-z0-9_\-]*\z/,
                                  message: "only lowercase letters, numbers, underscores and dashes allowed" }

  def login
    @login || username || email
    # @login || self.username || self.email
  end

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

end
