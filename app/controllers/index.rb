set :sessions, true

register do
  def logged_in (bool)
    condition do
      redirect "/" unless is_logged_in? == bool
    end
  end
end

helpers do
  def is_logged_in?
    @user != nil
  end
end

before do
  @user = User.find_by_id(session[:user_id])
end

get '/' do
  if is_logged_in?
    @twyt_list = @user.twyts_feed
    erb :feed
  else
    erb :index
  end
end

get '/profile', :logged_in => true do
  @our_profile = true
  @twyt_list = @user.twyts.reverse
  erb :profile
end

get '/profile/:username' do
  # TODO: Don't jack @user for this, would break any layout.erb things that use @user
  username = params[:username]
  if is_logged_in? && username == @user.username
    redirect to '/profile'
  end

  @user = User.find_by_username(username)
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

post '/twyt', logged_in: true do
  message = params[:twyt]
  if message.size < 140
    @user.post_twyt(message)
  else
    flash[:error] = "Error: Twyts must be 140 characters or less."
  end

  redirect to previous_url(request)
end

post '/follow', logged_in: true do
  user_to_follow = User.find_by_id(params[:user])

  if @user.follows_users.include? user_to_follow
    flash[:error] = 'Error: you are already following this user'
  else
    @user.follow(user_to_follow)
  end

  redirect to previous_url(request)
end

post '/favourite', logged_in: true do
  twyt = Twyt.find_by_id(params[:twyt_id])
  @user.favourite twyt

  flash[:success] = 'Added twyt to favourites!'

  redirect to previous_url(request)
end

