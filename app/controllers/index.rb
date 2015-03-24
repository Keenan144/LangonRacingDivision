get '/' do 
  erb :homepage
end

get '/login' do 
  erb :login
end

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