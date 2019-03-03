class TheAdminsController < ApplicationController 

    get "/admin" do 
        if_is_not_admin_redirect
        @users=User.all 
        erb :"admin/users/index.html",:layout => :admin_layout
    end

    get "/admin/search/users/:username" do 
        if @params[:username]!="all"
            @users=User.where("username like ?","%#{@params[:username]}%")
            # return "IT'S ALL"
        else 
            @users=User.all
            # return "IT'S NOT ALL"
        end
          
        
        result=[]

        @users.each_with_index do |user,index| 
           result.push({id:user.id,username:user.username,email:user.email,roles:user.roles.collect{|role| role.label}.join(",")})
        end
        
        jsonResult=result.to_json
     
     
        return "#{jsonResult}"
    end

    patch "/admin/users/:id" do 
        
        user=User.find_by(params[:id])
        if user 
            roles=@params[:roles].split(",")
            roles=roles.collect do |role| 
                Role.find_by(label:role)
            end
           User.update(params[:id],:username=>@params[:username],:email=>@params[:email],:roles=>roles)
            
            # return "#{user.update!}"
        else 
            flash[:danger]="No User exists for that id."
        end
        redirect "/admin"
    end


    # get "/admin/users/:id" do
    #     if_is_not_admin_redirect 
    #     @user=User.find(params[:id])
    #     if @user 
    #      erb :"admin/users/show.html",:locals=>{:current_page=>"admin_user_show"}
    #     else
    #       flash[:danger]="No User exist for that id."
    #       redirect "/"
    #     end
    # end

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

