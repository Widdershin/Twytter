9

User.create(username: 'Richard', email: 'rwoodnz@gmail.com', password_hash: User.hash_password('password'))
User.create(username: 'Kendall', email: 'kendall@gmail.com', password_hash: User.hash_password('password'))
User.create(username: 'Tim', email: 'tim@gmail.com', password_hash: User.hash_password('password'))

Follow.create(origin_id: 1, target_id: 2)
Follow.create(origin_id: 1, target_id: 3)
Follow.create(origin_id: 2, target_id: 3)

Twyt.create(id: 1, message: 'First twyt')
Twyt.create(id: 1, message: 'Second twyt')

