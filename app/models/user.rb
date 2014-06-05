class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :twyts

  # has_many :follows
  # has_many :followed_users, :through => :follows, source => User
  # has_many :followers, :through => :follows, source => User

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

  def to_s
    username
  end

  private

  def self.hash_password(password)
    Digest::MD5.hexdigest password
  end
end
