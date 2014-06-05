set :sessions, true

register do
  def auth (type)
    condition do
      redirect "/" unless is_user?
    end
  end
end

helpers do
  def is_user?
    @user != nil
  end
end

before do
  @user = User.find_by_id(session[:user_id])
end

get '/' do
# Look in app/views/index.erb
  erb :index
end

get '/profile', :auth => :user do
  @username = @user.username
  @twytlist = @user.twyts
  # @followers = @user.followers
  # @followed_users = @user.followed_users
  erb :profile
end

get '/profile/:username' do
  @user = User.find_by_username(params[:username])
  @username = @user.username; @twytlist = @user.twyts
  erb :profile
end

post '/login' do
  username = params[:username]
  password = params[:password]

  session[:user_id] = User.authenticate(username, password)

  redirect to '/profile'
end

post '/twyt' do
  message = params[:twyt]
  if message.size < 140
    @user.post_twyt(message)
  else
    flash[:error] = "Error: Twyts must be 140 characters or less."
  end

  redirect to '/profile'
end



