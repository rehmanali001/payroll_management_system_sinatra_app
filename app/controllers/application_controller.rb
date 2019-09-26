require './config/environment'
#require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "password_secret"
#    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user(session)
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?(session)
      !!session[:user_id]
    end
  end
end
