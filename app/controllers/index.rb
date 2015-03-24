get '/' do 
  erb :homepage
end


# ================== login routes ================== #

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])
 if @user && @user.authenticate(params[:password])
      session_set_current_user(@user)
      redirect('/')
  else
    @error = "invalid login"
 end
end

get "/logout" do
  session[:oauth] = {}
  session[:current_user_id] = nil
  redirect "/"
end

# ================== inspect the session ================== #

get "/session" do
  session.inspect
end

# ================== register routes ================== #

get '/register' do
  erb :newuser
  # in the new user form, ask for magic admin key. 
  # With admin key, you can post and edit SPECIFIC parts of the site. 
  # Not all parts! With out it, you are only subscribing, 
  # and in later versions you can maybe add comments and such
end

post '/register' do
  if User.find_by(email: params[:email]) == nil
  @new_user = User.create(username: params[:username], password: params[:password], email: params[:email])
    if @new_user.valid?
        session_set_current_user(@new_user)
        redirect('/')
    else
      erb :register
    end
  else
    @error = "that email is taken"
    erb :help
  end
end

# ================== create post routes ================== #


post '/user/:user_id/post' do 

  user = User.find(params[:user_id])
  post = user.posts.create(title: params[:title], content: params[:content])

  redirect '/'
end



















