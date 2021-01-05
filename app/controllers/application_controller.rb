require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !!/\w{1}@\w{1}/.match(params[:email]) && !!/\S{8}\W{1}/.match(params[:password])
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:message] = "Your account has successfuly been created."
    else
      flash[:message] = "<a href='/signup'>Your email or password is invalid. Please try again.</a>"
    end
  end
end
