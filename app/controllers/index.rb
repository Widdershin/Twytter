get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/profile', :auth => :user do
  @username = @user.username
  @twytlist = @user.twyts
  @followers = @user.followers
  @followed_users = @user.followed_users
  erb :profile
end

post '/profile' do
end

get '/profile/:id' do
end

post '/login' do
end
