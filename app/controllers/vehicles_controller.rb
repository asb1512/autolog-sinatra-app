class VehiclesController < ApplicationController
   get '/vehicles/new' do
      erb :'/vehicles/new'
   end
end