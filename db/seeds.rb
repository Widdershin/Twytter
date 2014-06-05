

User.create(username: 'Richard', email: 'rwoodnz@gmail.com', password_hash: User.hash_password('password'))
User.create(username: 'Kendall', email: 'kendall@gmail.com', password_hash: User.hash_password('password'))
# Follow.create(follower_id: 1, followed_user_id: 2)
# Twyt.create(user: 1, message: 'First twyt')
