require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "password_secret"
    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user
      @user = User.find(session[:user_id]) if session[:user_id]
    end

    def is_logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !is_logged_in?
        redirect "/login"
      end
    end

  end
end
