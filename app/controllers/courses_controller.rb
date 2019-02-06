class CoursesController < ApplicationController 

    def if_not_logged_in_go_home 
        if !is_logged_in?
            flash[:message]="Please log in to access the rest of the site."
            redirect to("/")
        end
    end

    get "/courses" do 
        if_not_logged_in_go_home()
        @courses=Course.all 
        erb :"courses/index.html",:locals => {:current_page => "curriculum"}
    end

    get "/courses/:id" do 
        if_not_logged_in_go_home()
        @course=Course.find_by_id(@params[:id])
        if @course
            erb :"courses/show.html",:locals=>{:current_page=>"course_show"}
        else 
            flash[:message]="Course with that id doesn't exist" 
            redirect "/"   
        end 
    end

    # CHAPTERS 
    get "/courses/:courseid/chapters" do 
      if_not_logged_in_go_home()
      @course=Course.find_by_id(@params[:courseid])
        
      if !@course 
        flash[:message]="Course with that id doesn't exist."
        redirect "/"
      end
      @chapters=@course.chapters

      erb :"courses/chapters/index.html",:locals => {:current_page=>"course_chapters"}  
    end

    get "/courses/:courseid/chapters/:chapterid" do 
        if_not_logged_in_go_home()
        @course=Course.find_by_id(@params[:courseid])

        if @course 
            @chapter=Chapter.find_by_id(@params[:chapterid])
            if @chapter && @course.chapters.include?(@chapter)
                erb:"courses/chapters/show.html",:locals => {:current_page=>"course_chapter_show"}
            else 
                flash[:message]="Course does not include this chapter or chapter with this id doesn't exist."
                redirect "/"
            end
        else 
            flash[:message]="Course with that id doesn't exist."
            redirect "/"
        end

       
      
    end

    #lessons 
    get "/courses/:courseid/chapters/:chapterid/lessons" do 
        if_not_logged_in_go_home()
        @course=Course.find_by_id(@params[:courseid])
        @chapter=Chapter.find_by_id(@params[:chapterid])

        if @course && @course.chapters.include?(@chapter)
            @lessons=@chapter.lessons
            erb:"courses/chapters/lessons/index.html",:locals => {:current_page=>"course_chapter_lessons"}
        else 
            flash[:message]="You have to pass the right ID for course and chapter."
            redirect "/"
        end

    end

    get "/courses/:courseid/chapters/:chapterid/lessons/:lessonid" do 
        if_not_logged_in_go_home()
        @course=Course.find_by_id(@params[:courseid])
        @chapter=Chapter.find_by_id(@params[:chapterid])
        @lesson=Lesson.find_by_id(@params[:lessonid]) 

        if @course && @chapter && @course.chapters.include?(@chapter) && @lesson && @chapter.lessons.include?(@lesson)
            erb:"courses/chapters/lessons/show.html",:locals => {:current_page=>"course_chapter_lessons"}
        else 
            flash[:message]="You have to pass the right ID for course, chapter and lesson."
            redirect "/"
        end 


    end
end