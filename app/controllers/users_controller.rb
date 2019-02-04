
class UsersController < ApplicationController 
    get "/users/new" do 
        erb :"users/new.html",:locals =>{:current_page => "signup"}
    end

    get "/users/:id" do 
        @user=User.find(@params[:id])
        erb :"users/show.html",:locals => {:current_page => ''}
    end

    post "/users" do 
        @user=User.new(username:@params[:username],password:@params[:password],password_confirmation:@params[:password_confirmation])
        if @user.save
            session[:user_id]=@user.id
            redirect "/users/#{@user.id}"
        else 
            redirect "/"
        end
    end
end