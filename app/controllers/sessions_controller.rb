class SessionsController < ApplicationController 

    get "/login" do 
        erb :"sessions/login.html",{:locals=>{:current_page=>"login"}}
    end

    post "/login" do 
        @user=User.find_by(username:@params[:username])

        if @user && @user.authenticate(@params[:password])
            session[:user_id]=@user.id 
            admin_role=Role.find_by(label:"admin")
            if @user.roles.include?(admin_role)
                redirect "/admin"
            end

            redirect "/users/#{@user.id}" 
        else 
            flash[:danger]="Username and password are incorrect. If you don't have an account please sign up."
            redirect "/login"
        end
    end

    post "/logout" do 
        if is_logged_in? 
         session.delete :user_id
         redirect "/"
        else
          redirect "/login"
        end
    end
end