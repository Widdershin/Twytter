class User < ActiveRecord::Base

  validates :username, uniqueness: true
  has_many :twyts
  has_many :favourite_twyts
  has_many :favourites, through: :favourite_twyts, source: :twyt

  has_many :follows_target, class_name: 'Follow', foreign_key: 'origin_id'
  has_many :follows_users, through: :follows_target, :source => 'target'

  has_many :is_followed_by_origin, class_name: 'Follow', foreign_key: 'target_id'
  has_many :is_followed_by, through: :is_followed_by_origin, :source => 'origin'

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    login_attempt_password_hash = hash_password(password)

    if login_attempt_password_hash == user.password_hash
      user.id
    else
      nil
    end
  end

  def self.make(options = {})
    username = options.fetch(:username)
    email = options.fetch(:email)
    password = options.fetch(:password)

    user = User.new(username: username, email: email)
    user.set_password(password)

    user.save!
    user
  end

  def set_password(password)
    self.password_hash = self.class.hash_password(password)
    save
  end

  def post_twyt(message)
    twyts.create(message: message)
  end

  def twyts_feed
    (self.twyts + followed_user_twyts).flatten.sort_by(&:created_at).reverse
  end

  def follow(user)
    follows_users << user
  end

  def favourite(twyt)
    favourites << twyt
  end

  def profile_link
    self.class.linkify_username(username)
  end

  def to_s
    username
  end

  private

  def self.hash_password(password)
    Digest::MD5.hexdigest password
  end

  def self.linkify_username(username)
    "<a href='/profile/#{username}'>#{username}</a>"
  end

  def followed_user_twyts
    follows_users.map(&:twyts)
  end
end
