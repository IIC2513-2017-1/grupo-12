class User < ApplicationRecord
  # Emails should be case insensitive
  before_save { email.downcase! }
  # Model validation
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # Password implementation
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns Full name in the format: 'Firstname Lastname'
  def fullname
    firstname.humanize + ' ' + lastname.humanize
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
