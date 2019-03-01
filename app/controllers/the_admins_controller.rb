class TheAdminsController < ApplicationController 
    get "/admin" do 
        if_is_not_admin_redirect
        @users=User.all 
        erb :"admin/users/index.html",:layout => :admin_layout
    end

    get "/admin/users/:id" do
        if_is_not_admin_redirect 
        @user=User.find(params[:id])
        if @user 
         erb :"admin/users/show.html",:locals=>{:current_page=>"admin_user_show"}
        else
          flash[:danger]="No User exist for that id."
          redirect "/"
        end
    end

    get "/admin/users/:id/edit" do
        if_is_not_admin_redirect 
        @users=User.all 
        erb :"admin/users/edit.html",:layout => :admin_layout
    end


    get "/admin/courses" do 
        if_is_not_admin_redirect 
        
        erb :"admin/courses/index.html",:layout => :admin_layout
    end
end

