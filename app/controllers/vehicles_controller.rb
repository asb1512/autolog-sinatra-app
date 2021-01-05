class VehiclesController < ApplicationController
   get '/vehicles/new' do
      if logged_in?
         erb :'/vehicles/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or create an account.</p><p><a href='/signup'>Sign Up</a></p><p><a href='/login'>Login</a></p>"
      end
   end

   post '/vehicles' do
      binding.pry
   end
end