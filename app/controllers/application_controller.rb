class ApplicationController < Sinatra::Base     

    configure do
        enable :sessions
        set :session_secret, 'super_secret_token'
        set :public_folder, 'public'
        set :views, 'app/views'
      end
    


    get "/" do 
        erb :"home.html", :locals => {:current_page => "home"}
    end
end