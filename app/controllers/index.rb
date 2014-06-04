set :sessions, true

register do
  def auth (type)
    condition do
      redirect "/login" unless send("is_#{type}?")
    end
  end
end

helpers do
  def is_user?
    @user != nil
  end
end

before do
  user_id = session[:user_id]
  @user = if !user_id.nil?
            User.find(user_id)
          else
            nil
          end
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/profile', :auth => :user do
  @user.username
end

get '/profile/:id' do
end

post '/login' do
  username = params[:username]
  password = params[:password]

  session[:user_id] = User.authenticate(username, password)

  redirect to '/profile'
end
