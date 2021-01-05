class VehiclesController < ApplicationController
   get '/vehicles/new' do
      if logged_in?
         erb :'/vehicles/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or create an account.</p><p><a href='/signup'>Sign Up</a></p><p><a href='/login'>Login</a></p>"
      end
   end

   post '/vehicles' do
      vehicle = Vehicle.create(model_year: params[:model_year], make: params[:make], model: params[:model], mileage: params[:mileage])
      current_user.vehicles << vehicle
      current_user.save
      redirect "/#{current_user.email}"
   end
end