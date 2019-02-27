

class ApplicationController < Sinatra::Base     
    use Rack::Flash,:accessorize=>[:warning,:danger,:success,:primary,:secondary]
    configure do    
        enable :sessions
        set :session_secret, 'super_secret_token'
        set :public_folder, 'public'
        set :views, 'app/views'
      end
      use Rack::Flash
    
    helpers do 
        def current_user 
            if session[:user_id].nil? 
                nil 
            else 
                User.find_by(id:session[:user_id])
            end
        end

        def is_logged_in? 
            current_user == nil ? false : true
        end
    end


    get "/" do 
        erb :"home.html", :locals => {:current_page => "home"}
    end
end