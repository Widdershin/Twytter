class User < ActiveRecord::Base
  has_many :twyts

  # has_many :follows
  # has_many :followed_users, :through => :follows, source => User
  # has_many :followers, :through => :follows, source => User

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
