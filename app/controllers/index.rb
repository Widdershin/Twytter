get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/profile' do
  if session['user_id'] != nil
    user = User.find_by_id(session['user_id'])
    @username = user.username
    @twytlist = Tweet.where(id: session['user_id'])
    @followers = User.followers
    @followed_users = User.followed_users
    erb :profile
  else
    redirect('/')
  end
end

post '/profile' do
end

get '/profile/:id' do
end

post '/login' do
end
