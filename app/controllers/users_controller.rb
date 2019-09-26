class UsersController < ApplicationController

    get '/signup' do
      if is_logged_in?(session)
        flash[:message] = "You're already logged in!"
        redirect '/employees'
      else
        erb :"users/signup"
      end
    end

    post '/signup' do
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
  #      binding.pry
        if @user.id == nil
          flash[:message] = "Invalid user credentials. Please try again."
          redirect '/signup'
       else
         session[:user_id] = @user.id
        redirect '/login'
    end
    end

    get '/login' do
        if is_logged_in?(session)
          flash[:message] = "You're already logged in"
          redirect '/employees'
        end
          erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/employees'
        else
        flash[:message] = "Incorrect login credentials. Please try again."
        redirect '/login'
      end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end
