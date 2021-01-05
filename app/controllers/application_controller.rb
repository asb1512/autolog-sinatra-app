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
    if !!/\w{1}@\w{1}/.match(params[:email]) && !!/\S{7}\W{1}/.match(params[:password])
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "Your account has successfuly been created."
    else
      flash[:message] = "<p>Your email or password is invalid. Please try again.</p><p>Back to <a href='/signup'>Sign Up</a></p>"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
  end
end
