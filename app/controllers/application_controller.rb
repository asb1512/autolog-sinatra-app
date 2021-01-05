require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    binding.pry
    if !!/\w{1}@\w{1}/.match(params[:email]) && !!/\S{8}\W{1}/.match(params[:password])
      user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = user.id
    else
      redirect "/signup"
    end
  end
end
