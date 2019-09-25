class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do 
        erb :"users/signup"
    end

    post '/signup' do 
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/employees'
    end 

    get '/login' do 
        
        erb :"users/login"
    end 

    post '/login' do 
        @user = User.find_by(email: params[:email], password: params[:password])
        if @user 
            session[:user_id] = @user.id 
            redirect '/employees'
        end 
        redirect '/login'
    end

    get '/logout' do 
        session.clear 
        redire '/'
    end
end 
