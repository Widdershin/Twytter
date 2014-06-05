class User < ActiveRecord::Base

  validates :username, uniqueness: true
  has_many :twyts

  has_many :follows_target, class_name: 'Follow', foreign_key: 'origin_id'
  has_many :follows_users, through: :follows_target, :source => 'target'
  belongs_to :target, class_name: 'Follow'

  has_many :is_followed_by_origin, class_name: 'Follow', foreign_key: 'target_id'
  has_many :is_followed_by, through: :is_followed_by_origin, :source => 'origin'
  belongs_to :origin, class_name: 'Follow'


  def set_password(password)
    self.password_hash = self.class.hash_password(password)
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    login_attempt_password_hash = hash_password(password)

    if login_attempt_password_hash == user.password_hash
      user.id
    else
      nil
    end
  end

  private

  def self.hash_password(password)
    Digest::MD5.hexdigest password
  end
end
