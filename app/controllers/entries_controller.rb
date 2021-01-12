class EntriesController < ApplicationController

   get '/entries/new' do
      if logged_in?
         erb :'/entries/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

   get '/entries/:id' do
      if logged_in?
         @entry = Entry.find(params[:id])
         @vehicle = Vehicle.find(@entry.vehicle_id)
         erb :'/entries/show'
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

   post '/entries' do
      if params[:entry_type].empty? || params[:entry_content].empty? || params[:vehicles].empty?
         flash[:message] = "<p>You must include a maintenance type, a description, and an assigned vehicle. <a href='/entries/new'>Return to Entry</a></p>"
      elsif params[:due_date]
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content], due_date: params[:due_date])
         vehicle = Vehicle.find(params[:vehicles].first)
         vehicle.entries << entry
         vehicle.save
         redirect "entries/#{entry.id}"
      else
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content])
         vehicle = Vehicle.find(params[:vehicles].first)
         vehicle << entry
         vehicle.save
         redirect "entries/#{entry.id}"
      end
   end

   get '/entries/:id/edit' do
      @entry = Entry.find(params[:id])
      erb :'/entries/edit'
   end

   patch '/entries/:id' do
      @entry = Entry.find(params[:id])
      if @entry
         if logged_in?
            
         else

         end
      else
         flash[:message] = "<p>Entry not found.</p><p>Back to <a href='/#{current_user.email}'>Account</a></p>"
      end
   end

end