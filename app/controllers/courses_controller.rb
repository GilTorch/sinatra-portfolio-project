class CoursesController < ApplicationController 
    get "/courses" do 
        @courses=Course.all 
        erb :"courses/index.html",:locals => {:current_page => "curriculum"}
    end

    get "/courses/:id" do 
        @course=Course.find_by(id:params[:id])
        if @course 
            erb :"courses/show.html",:locals => {:current_page=>"course_show"}
        else 
            # FLASH MESSAGE : COURSE DOESN'T EXIST 
            redirect "/"
        end
    end

    get "/courses/:id/chapters" do 
       @course=Course.find_by(id:params[:id])
       if @course 
         erb :"courses/chapters/index.html",:locals=>{:current_page=>"course_chapters"}
       else 
         #FLASH MESSAGE : COURSE DOESN'T EXIST
         redirect "/"
       end
    end 

    get "/courses/:courseid/chapters/:chapterid" do 
        @course=Course.find_by(id:params[:courseid])
       if @course 
         @chapter=Chapter.find_by(id:params[:chapterid])
         if @chapter && @course.chapters.include?(@chapter)
            erb :"courses/chapters/show.html",:locals=>{:current_page=>"course_chapters_show"}
         else 
            #FLASH MESSAGE: CHAPTER DOESN'T EXIST OR IS NOT INCLUDED IN THIS COURSE 
            redirect "/"
         end
       else 
         #FLASH MESSAGE : COURSE DOESN'T EXIST
         redirect "/"
       end
    end

end