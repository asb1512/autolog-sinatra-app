class UsersController < ApplicationController
   
   get '/signup' do
      erb :'users/signup'
   end

   post '/signup' do
      if params[:password] != params[:password_confirmation]
      flash[:message] = "<p>Your passwords do not match. Please try again.</p><p>Back to <a href='/signup'>Sign Up</a></p>"
      elsif User.find_by(email: params[:email])
      flash[:message] = "<p>This email is already taken. Please use a different email address.</p><p>Back to <a href='/signup'>Sign Up</a></p>"
      elsif !!/\w{1}@\w{1}/.match(params[:email]) && !!/\S{7}\W{1}/.match(params[:password])
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "<p>Your account was successfully created.</p><p>Back to <a href='/users/#{current_user.email}'>Profile</a></p>"
      else
      flash[:message] = "<p>Your email or password is invalid. Please try again.</p><p>Back to <a href='/signup'>Sign Up</a></p>"
      end
   end

   get '/login' do
      if !logged_in?
      erb :'users/login'
      else
      redirect "/users/#{current_user.email}"
      end
   end

   post '/login' do
      @user = User.find_by(email: params[:email])
      
      if @user && @user.authenticate(params[:password])
      session
      session[:user_id] = @user.id
      
      redirect to "/users/#{@user.email}"
      else
      flash[:message] = "<p>Your email or password is invalid. Please try again.</p><p>Back to <a href='/login'>Login</a></p>"
      end
   end

   get '/users/:email' do
      if logged_in? && current_user.email == params[:email]
      erb :'/users/show'
      else
      flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end
end