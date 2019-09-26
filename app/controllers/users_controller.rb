class UsersController < ApplicationController

    get '/signup' do
        erb :"users/signup"
    end

    post '/signup' do
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
       if user.save
          redirect '/login'
       else
        redirect '/'
    end
    end

    get '/login' do

        erb :"users/login"
    end

    post '/login' do
        @user = User.find_by(email: params[:email], password: params[:password])
        if @user && user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/employees'
        end
        redirect '/login'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end
