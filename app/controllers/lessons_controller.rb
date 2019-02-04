class LessonsController < ApplicationController 

    get "/lessons/:id" do 
        @lesson=Lesson.find(@params[:id])
        erb :"lessons/show.html",{:locals =>{:current_page =>"lessons_show"}}
    end
end