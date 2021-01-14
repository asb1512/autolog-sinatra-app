class VehiclesController < ApplicationController
   get '/vehicles/new' do
      if logged_in?
         erb :'/vehicles/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or create an account.</p><p><a href='/signup'>Sign Up</a></p><p><a href='/login'>Login</a></p>"
      end
   end

   post '/vehicles' do
      if params[:model_year].include?(" ") || params[:make].include?(" ") || params[:model].include?(" ") || params[:mileage].include?(" ")
         flash[:message] = "<p>You cannot include spaces in the year, make, model, or mileage. Please try again.</p><p><a href='/vehicles/new'>Back</a></p>"
      else
         vehicle = Vehicle.create(model_year: params[:model_year], make: params[:make].downcase, model: params[:model].downcase, mileage: params[:mileage])
         current_user.vehicles << vehicle
         current_user.save
         redirect "/#{current_user.email}"
      end
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

   patch '/vehicles/:slug' do
      @vehicle = Vehicle.find_by_slug(params[:slug])
      if @vehicle
         if logged_in?
            if params[:model_year].include?(" ") || params[:make].include?(" ") || params[:model].include?(" ") || params[:mileage].include?(" ")
                  flash[:message] = "<p>You cannot include spaces in the year, make, model, or mileage. Please try again.</p><p><a href='/vehicles/new'>Back</a></p>"
            else
               Vehicle.update(@vehicle.id, model_year: params[:model_year], make: params[:make].downcase, model: params[:model].downcase, mileage: params[:mileage])
               flash[:message] = "<p>Your email was successfully updated.</p><p>Back to <a href='/#{current_user.email}'>Profile</a></p>"
               redirect "/#{current_user.email}"
            end
         else
            flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
         end
      else
         flash[:message] = "<p>Vehicle not found.</p><p>Back to <a href='/#{current_user.email}'>Vehicles</a></p>"
      end
   end

   delete '/vehicles/:id' do
      @vehicle = Entry.find(params[:id])
      if logged_in?
         if @vehicle
            @vehicle.destroy
            flash[:message] = "<p>Your entry has successfully been deleted.</p><p><a href='/#{current_user.email}'>Account</a></p>"
         else
            flash[:message] = "<p>Entry not found.</p><p>Back to <a href='/#{current_user.email}'>Account</a></p>"
         end
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

end