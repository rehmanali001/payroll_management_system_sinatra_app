class UsersController < ApplicationController

    get '/signup' do
      if is_logged_in?
        redirect '/employees'
      else
        erb :"users/signup"
      end
    end

    post '/signup' do
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
  #      binding.pry
      if @user.id == nil
        redirect '/signup'
      else
         session[:user_id] = @user.id
        redirect '/login'
      end
    end

    get '/login' do
        if is_logged_in?
          redirect '/employees'
        end
          erb :'users/login'
    end

    post '/login' do
      if is_logged_in?
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/employees'
        end
      end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/users/:id' do
      @user = User.find(params[:id])
      @employees = @user.employees
      erb :'/users/show'

    end
end
