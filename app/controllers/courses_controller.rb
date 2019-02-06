class CoursesController < ApplicationController 
    get "/courses" do 
        @courses=Course.all 
        erb :"courses/index.html",:locals => {:current_page => "curriculum"}
    end

    get "/courses/:id" do 
        @course=Course.find(@params[:id])
        erb :"courses/show.html",:locals=>{:current_page=>"course_show"}
    end

    # CHAPTERS 
    get "/courses/:courseid/chapters" do 
      @course=Course.find(@params[:courseid])
      @chapters=@course.chapters
      erb :"courses/chapters/index.html",:locals => {:current_page=>"course_chapters"}  
    end

    get "/courses/:courseid/chapters/:chapterid" do 
        @course=Course.find(@params[:courseid])
        @chapter=Chapter.find(@params[:chapterid])
        if @course.chapters.include?(@chapter)
            erb:"courses/chapters/show.html",:locals => {:current_page=>"course_chapter_show"}
        end
    end

    #lessons 
    get "/courses/:courseid/chapters/:chapterid/lessons" do 
        @course=Course.find(@params[:courseid])
        @chapter=Chapter.find(@params[:chapterid])

        if @course && @chapter
            @lessons=@chapter.lessons
            erb:"courses/chapters/lessons/index.html",:locals => {:current_page=>"course_chapter_lessons"}
        else 
            redirect "/"
        end

    end

    get "/courses/:courseid/chapters/:chapterid/lessons/:lessonid" do 
        @course=Course.find(@params[:courseid])
        @chapter=Chapter.find(@params[:chapterid])
        @lesson=Lesson.find(@params[:lessonid]) 

        if @course && @chapter && @lesson 
            erb:"courses/chapters/lessons/show.html"
        else 
            redirect "/"
        end

    end

end