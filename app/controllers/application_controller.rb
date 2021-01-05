require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :views, Proc.new { File.join(root, "../views/") }
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if params[:password] != params[:password_confirmation]
      flash[:message] = "<p>Your passwords do not match. Please try again.</p><p>Back to <a href='/signup'>Sign Up</a></p>"
    elsif !!/\w{1}@\w{1}/.match(params[:email]) && !!/\S{7}\W{1}/.match(params[:password])
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "Your account has successfuly been created."
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
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{current_user.email}"
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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
