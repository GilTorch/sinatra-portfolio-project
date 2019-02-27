
class UsersController < ApplicationController 
    get "/users/new" do 
        erb :"users/new.html",:locals =>{:current_page => "signup"}
    end

    get "/users/:id" do 
        @user=User.find_by(id:@params[:id])
        if @user 
          erb :"users/show.html",:locals => {:current_page => ''}
        else
            #FLASH MESSAGE:"THIS USER DOESN'T EXIST" 
            redirect "/" 
        end
    end

    post "/users" do 
        @user=User.new(username:@params[:username],password:@params[:password],password_confirmation:@params[:password_confirmation])
        if @user.save
            flash[:success]="Account has been created successfully. You are automatically logged in."
            session[:user_id]=@user.id
            redirect "/users/#{@user.id}"
        else 
            redirect "/"
        end
    end
end