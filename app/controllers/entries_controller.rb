class EntriesController < ApplicationController

   get '/entries/new' do
      if logged_in?
         erb :'/entries/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

   post '/entries' do
      binding.pry
      if params[:entry_type].empty? || params[:entry_content].empty? || params[:vehicles]
         flash[:message] = "<p>You must include a maintenance type, a description, and an assigned vehicle. <a href='/entries/new'>Return to Entry</a></p>"
      elsif params[:due_date]
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content], due_date: params[:due_date])
         vehicle = Vehicle.find(params[:vehicles].first)
         vehicle << entry
         vehicle.save
      else
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content])
         vehicle = Vehicle.find(params[:vehicles].first)
         vehicle << entry
         vehicle.save
      end
   end

end