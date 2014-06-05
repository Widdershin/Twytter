
Follow.create(origin_id: 1, target_id: 2)
Follow.create(origin_id: 1, target_id: 3)
Follow.create(origin_id: 2, target_id: 3)

Twyt.create(id: 1, message: 'First twyt')
Twyt.create(id: 1, message: 'Second twyt')

User.make(username: 'Richard', email: 'rwoodnz@gmail.com', password: 'password')
User.make(username: 'Kendall', email: 'kendall@gmail.com', password: 'password')
User.make(username: 'Time', email: 'tim@gamil.como', password: 'password')
# Follow.create(follower_id: 1, followed_user_id: 2)
# Twyt.create(user: 1, message: 'First twyt')
