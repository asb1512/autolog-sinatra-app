class EntriesController < ApplicationController

   get '/entries/new' do
      if logged_in?
         erb :'/entries/new'
      else
         flash[:message] = "<p>You are not logged in. Please login or sign up.</p><p>Back to <a href='/login'>Login</a> or <a href='/signup'>Sign Up</a>.</p>"
      end
   end

   post '/entries' do
      if params[:due_date]
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content], due_date: params[:due_date])
      else
         entry = Entry.create(entry_type: params[:entry_type], entry_content: params[:entry_content])
      end
   end

end