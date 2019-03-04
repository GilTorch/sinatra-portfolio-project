class TheAdminsController < ApplicationController 

    get "/admin" do 
        if_is_not_admin_redirect
        @users=User.all 
        @js="searchUsers"
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
    post "/admin/users" do 
        
        
        
            roles=@params[:roles].split(",")
            roles=roles.collect do |role| 
                Role.find_by(label:role)
            end
          user= User.new(:username=>@params[:username],:email=>@params[:email],password:"nopassword",password_confirmation:"nopassword")
          user.roles=roles
         if user.save
            redirect "/admin"
         else 
            redirect "/admin"
            flash[:danger]="Could Not Add The User."
         end
            # return "#{user.update!}"
       
      
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

    delete "/admin/users/:id" do 
        if_is_not_admin_redirect 
        User.find(params[:id]).destroy
        redirect "/admin"
    end

    get "/admin/users/:id/edit" do
        if_is_not_admin_redirect 
        @users=User.all 
        erb :"admin/users/edit.html",:layout => :admin_layout
    end

    # courses 
    get "/admin/courses" do 
        if_is_not_admin_redirect 
        @courses=Course.all
        @js="searchCourses"
        erb :"admin/courses/index.html",:layout => :admin_layout
    end

    get "/admin/search/courses/:title" do 
        if @params[:title]!="all"
            @courses=Course.where("title like ?","%#{@params[:title]}%")
            # return "IT'S ALL"
        else 
            @courses=Course.all
            # return "IT'S NOT ALL"
        end
          
        
        result=[]

        @courses.each_with_index do |course| 
           result.push({id:course.id,title:course.title,chapters_count:course.chapters.count})
        end
        
        jsonResult=result.to_json
     
     
        return "#{jsonResult}"
    end

end

