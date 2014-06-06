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
  if is_user?
    @twyt_list = @user.twyts_following
    erb :feed
  else
    erb :index
  end
end

get '/profile', :auth => :user do
  @our_profile = true
  @twyt_list = @user.twyts.reverse
  erb :profile
end

get '/profile/:username' do
  # TODO: Don't jack @user for this, would break any layout.erb things that use @user
  @user = User.find_by_username(params[:username])
  @twyt_list = @user.twyts.reverse
  erb :profile
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/login' do
  username = params[:username]
  password = params[:password]

  session[:user_id] = User.authenticate(username, password)

  redirect to '/'
end

post '/twyt' do
  message = params[:twyt]
  if message.size < 140
    @user.post_twyt(message)
  else
    flash[:error] = "Error: Twyts must be 140 characters or less."
  end

  redirect to previous_url(request)
end

post '/follow' do
  user_to_follow = User.find_by_id(params[:user])

  if @user.follows_users.include? user_to_follow
    flash[:error] = 'Error: you are already following this user'
  else
    @user.follow(user_to_follow)
  end

  redirect to previous_url(request)
end

