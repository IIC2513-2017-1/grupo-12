class User < ApplicationRecord
  attr_accessor :activation_token
  before_save { email.downcase! }
  before_create :create_activation_digest
  # Model validation
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # Password implementation (includes authenticate method)
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :active_project_relationships, class_name:  'ProjectRelationship',
                                          foreign_key: 'saver_id',
                                          dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :saving, through: :active_project_relationships, source: :saved
  has_many :projects
  has_many :donations
  has_many :comments
  validates_associated :projects
  validates_associated :donations
  validates_associated :comments

  has_attached_file :avatar,
                    styles: {
                      thumb: '40x40',
                      small: '150x150>',
                      medium: '200x200'
                    },
                    content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                    default_url: '/default/default_avatar_:style.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]

  # Returns Full name in the format: 'Firstname Lastname'
  def fullname
    name = firstname + ' ' + lastname
    name.split.map(&:capitalize).join(' ')
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def save_project(project)
    saving << project unless saving.include? project
  end

  def forget_project(project)
    saving.delete(project)
  end

  def saving?(project)
    saving.include?(project)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
