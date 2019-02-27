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

            # checking if this particular user passed this lesson or not
            if(current_user.lessons.nil?)
              @passed=false 
            else 
              if(current_user.lessons.include?(@lesson))
                @passed=true
              else 
                @passed=false
              end
            end

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

    patch "/courses/:courseid/chapters/:chapterid/lessons/:lessonid" do 
      if_not_logged_in_redirect
      @course=Course.find_by(id:params[:courseid])
      @chapter=Chapter.find_by(id:params[:chapterid])

      if !@course 
        flash[:danger]="This course doesn't exist."
      end

      if !@chapter && !@course.chapters.include?(@chapter)
        flash[:danger]="This chapter doesn't exist or is not included in this course."
      end

      @lesson=Lesson.find_by(id:params[:lessonid])
      if @lesson 
        userlesson=UserLesson.find_by(lesson_id:@lesson.id,user_id:current_user.id)

        if !userlesson
          userlesson=UserLesson.create(user_id:current_user.id,lesson_id:@lesson.id,passed:false)
        end
        
        if(@params["pass_lesson"])
          flash[:success]="You successfuly passed this lesson."
          userlesson.passed=true 
          userlesson.save
        end

        if(@params["reset_lesson"])
          flash[:secondary]="You have reset this lesson."
          userlesson.delete
        end
        redirect "/courses/#{@course.id}/chapters/#{@chapter.id}/lessons/#{@lesson.id}"
      else 
          flash[:danger]="The lesson id you passed doesn't exist."
         redirect "/"
      end
  end 




end