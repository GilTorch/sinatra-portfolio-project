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

    post "/admin/courses" do 
        @course=Course.new(title:@params[:title])
        if @course.save 
            redirect "/admin/courses"
        else 
            flash[:danger]="There was an issue while adding the course..."
            redirect "/admin/courses"
        end
    end

    patch "/admin/courses/:id" do 
        
        course=Course.find_by(params[:id])
        if course 
           Course.update(params[:id],:title=>@params[:title])
            # return "#{user.update!}"
        else 
            flash[:danger]="No Course exists for that id."
        end
        redirect "/admin/courses"
    end

    delete "/admin/courses/:id" do 
        if_is_not_admin_redirect 
        Course.find(params[:id]).destroy
        redirect "/admin/courses"
    end

    # chapters ...

    get "/admin/chapters" do 
        if_is_not_admin_redirect 
        @chapters=Chapter.all
        erb :"admin/chapters/index.html",:layout => :admin_layout
    end

    patch "/admin/courses/:courseid/chapters/:chapterid" do 
        if_is_not_admin_redirect 
         
        course=Course.find_by(id:params[:courseid])
        if course 
           chapter=Chapter.find_by(params[:chapter_id])
           if chapter 
            title=@params[:title]
            chapter.title=title 
            course_passed=Course.find_or_create_by(title:@params[:course])
            chapter.course=course_passed 
            if !chapter.save 
                flash[:danger]="There was a problem while editing your chapter"
            end
           else 
            flash[:danger]="No Chapter exists for that id"
           end
        else 
            flash[:danger]="No Course exists for that id."
        end
        redirect "/admin/chapters"
    end

    post "/admin/chapters" do 
        chapter=Chapter.new(title:@params[:title])
        if chapter 
            course=Course.find_or_create_by(title:@params[:course])
            if course 
                chapter.course=course 
                if chapter.save
                    flash[:sucess]="Successfully created the Chapter"
                else 
                    flash[:danger]="An error happened while trying to save the chapter..."
                end
            else 
              flash[:danger]="Something went wrong while searching the course"
            end
        else 
            flash[:danger]="Something went wrong while creating the chapter..."
        end
        redirect "/admin/chapters"
    end
 
    delete "/admin/chapters/:id" do 
        chapter=Chapter.find_by(id:params[:id])
        if chapter 
            chapter.destroy 
        else 
            flash[:danger]="No Chapter exists for that id"
        end
        redirect "/admin/chapters"
    end

    # lessons
    
    get "/admin/lessons" do 
        if_is_not_admin_redirect 
        @lessons=Lesson.all
        erb :"admin/lessons/index.html",:layout => :admin_layout
    end

    patch "/admin/courses/:courseid/chapters/:chapterid/lessons/:lessonid" do 
        if_is_not_admin_redirect 
         
        course=Course.find_by(id:params[:courseid])
        if course 
           chapter=Chapter.find_by(params[:chapter_id])
           if chapter 
            lesson=Lesson.find_by(params[:lesson_id])
            if lesson
                lesson.title=@params[:title]
                course_passed=Course.find_or_create_by(title:@params[:course])
                chapter_passed=Chapter.find_or_create_by(title:@params[:chapter])
                chapter_passed.course=course_passed
                chapter.save
                lesson.chapter=chapter_passed 
                if lesson.save 
                    flash[:success]="Lesson was successfully modified."
                else 
                    flash[:success]="There was a mistake while modifying your lesson"
                end
            else 

            end
           else 
            flash[:danger]="No chapter with that id was found."
           end
        else 
            flash[:danger]="No course with that id was found."
        end
        redirect "/admin/lessons"
    end

    delete "/admin/lessons/:id" do 
        lesson=Lesson.find_by(id:params[:id])
        if lesson 
            lesson.destroy 
        else 
            flash[:danger]="No Lesson exists for that id"
        end
        redirect "/admin/lessons"
    end

    post "/admin/lessons" do 
        lesson=Lesson.new(title:@params[:title])
        chapter=Chapter.find_or_create_by(title:@params[:chapter])
        course=Course.find_or_create_by(title:@params[:course])
        chapter.course=course 
        chapter.save 
        lesson.chapter=chapter 
        if lesson.save
            flash[:success]="Lesson was successfully created"
        else
            flash[:danger]="An error occured while creating the course" 
        end   
        redirect "/admin/lessons"
    end
end

