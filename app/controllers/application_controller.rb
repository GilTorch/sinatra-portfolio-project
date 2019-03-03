

class ApplicationController < Sinatra::Base     
    use Rack::Flash,:accessorize=>[:warning,:danger,:success,:primary,:secondary]
    configure do    
        enable :sessions
        set :session_secret, 'super_secret_token'
        set :views, 'app/views'
        set :public_folder, Proc.new { File.join("./", "public") }
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

    def if_not_logged_in_redirect 
        if(!is_logged_in?)
          flash[:danger]="Please login to be able to do this action."
          redirect "/"
        end
    end

    def is_an_admin? 
        admin_role=Role.find_by(label:"admin")
        if !is_logged_in? || !current_user.roles.include?(admin_role)
            return false
        else 
            return true 
        end
    end

    def if_is_not_admin_redirect 
        if !is_an_admin?
            redirect "/"
        end
     end
end