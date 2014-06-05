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
    erb :feed
  else
    erb :index
  end
end

get '/profile', :auth => :user do
  @show_twyt_bar = true
  erb :profile
end

get '/profile/:username' do
  # TODO: Don't jack @user for this, would break any layout.erb things that use @user
  @user = User.find_by_username(params[:username])
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



