class VehiclesController < ApplicationController
   get '/vehicles/new' do
      if logged_in?
         erb :'/vehicles/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or create an account.</p><p><a href='/signup'>Sign Up</a></p><p><a href='/login'>Login</a></p>"
      end
   end

   post '/vehicles' do
      vehicle = Vehicle.create(model_year: params[:model_year], make: params[:make].downcase, model: params[:model].downcase, mileage: params[:mileage])
      current_user.vehicles << vehicle
      current_user.save
      redirect "/#{current_user.email}"
   end

   get '/vehicles/:slug' do
      if logged_in?
         @vehicle = Vehicle.find_by_slug(params[:slug])
         if @vehicle
            erb :'vehicles/show'
         else
            flash[:message] = "<p>Vehicle not found.</p><p>Back to <a href='/#{current_user.email}'>Vehicles</a></p>"
         end
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

   get '/vehicles/:slug/edit' do
      if logged_in?
         @vehicle = Vehicle.find_by_slug(params[:slug])
         if @vehicle
            erb :'vehicles/edit'
         else
            flash[:message] = "<p>Vehicle not found.</p><p>Back to <a href='/#{current_user.email}'>Vehicles</a></p>"
         end
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

end