class CoursesController < ApplicationController 

   

    get "/courses" do
      if_not_logged_in_redirect 
        @courses=Course.all 
        erb :"courses/index.html",:locals => {:current_page => "curriculum"}
    end

    get "/courses/:id" do
      if_not_logged_in_redirect 
        @course=Course.find_by(id:params[:id])
        if @course 
            erb :"courses/show.html",:locals => {:current_page=>"course_show"}
        else 
            # FLASH MESSAGE : COURSE DOESN'T EXIST 
            puts flash.inspect
            flash[:danger]="This course doesn't exist."
            redirect "/"
        end
    end

    get "/courses/:id/chapters" do
      if_not_logged_in_redirect 
       @course=Course.find_by(id:params[:id])
       if @course 
         erb :"courses/chapters/index.html",:locals=>{:current_page=>"course_chapters"}
       else 
        flash[:danger]="This course doesn't exist."
         redirect "/"
       end
    end 

    get "/courses/:courseid/chapters/:chapterid" do
      if_not_logged_in_redirect 
        @course=Course.find_by(id:params[:courseid])
       if @course 
         @chapter=Chapter.find_by(id:params[:chapterid])
         if @chapter && @course.chapters.include?(@chapter)
            erb :"courses/chapters/show.html",:locals=>{:current_page=>"course_chapters_show"}
         else 
            #FLASH MESSAGE: CHAPTER DOESN'T EXIST OR IS NOT INCLUDED IN THIS COURSE 
            flash[:danger]="This chapter doesn't exist or is not included in this course."
            redirect "/"
         end
       else 
        flash[:danger]="This course doesn't exist."
         redirect "/"
       end
    end

    get "/courses/:courseid/chapters/:chapterid/lessons/:lessonid" do
      if_not_logged_in_redirect 
      @course=Course.find_by(id:params[:courseid])
      if @course 
        @chapter=Chapter.find_by(id:params[:chapterid])
        if @chapter && @course.chapters.include?(@chapter)
          @lesson=Lesson.find_by(id:params[:lessonid])
          if @lesson && @chapter.lessons.include?(@lesson) 
            erb:"courses/chapters/lessons/show.html",:locals=>{:current_page=>"courses_chapters_lessons_show"}
          else 
            flash[:danger]="This lesson doesn't exist or is not included in this chapter."
            redirect "/"
          end
        else 
           #FLASH MESSAGE: CHAPTER DOESN'T EXIST OR IS NOT INCLUDED IN THIS COURSE 
           flash[:danger]="This chapter doesn't exist or is not included in this course."
           redirect "/"
        end
      else 
        flash[:danger]="This course doesn't exist."
        redirect "/"
      end
    end

    def if_not_logged_in_redirect 
      if(!is_logged_in?)
        flash[:danger]="Please login to be able to do this action."
        redirect "/"
      end
    end

end