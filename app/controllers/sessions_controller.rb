class SessionsController < ApplicationController 

    get "/login" do 
        erb :"sessions/login.html",{:locals=>{:current_page=>"login"}}
    end

    post "/login" do 
        @user=User.find_by(username:@params[:username])

        if @user && @user.authenticate(@params[:password])
            session[:user_id]=@user.id 
            redirect "/users/#{@user.id}" 
        else 
            flash[:message]="Username and password are incorrect. If you don't have an account please sign up."
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