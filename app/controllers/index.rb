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

 
get "/upload" do
  haml(:upload)
end
 
post '/upload' do
  unless params[:file] &&
         (tmpfile = params[:file][:tempfile]) &&
         (name = params[:file][:filename])
    @error = "No file selected"
    return haml(:upload)
  end
    directory = "public/files"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(tmpfile.read) }
  redirect "/"

end

# ================== navbar routes ================== #

get '/contact' do
  erb :contact
end

get '/garage' do 
  erb :garage
end

get '/media' do
  erb :media
end

get '/news' do 
  erb :news
end

get '/schedule' do 
  erb :schedule
end

get '/teamLRD' do 
  erb :teamLRD
end

# =================== New Car ====================#


post '/newcar' do
  @new_car = Car.create(
    info: params[:info],
    make: params[:make],
    model: params[:model],
    engine: params[:engine],
    drive: params[:drive],
    color: params[:color], 
    horsepower: params[:horsepower],
    top_speed: params[:top_speed],
    noto_sixty: params[:noto_sixty],
    number: params[:number]
    )
  redirect '/garage'
end













