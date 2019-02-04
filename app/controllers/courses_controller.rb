class CoursesController < ApplicationController 
    get "/courses" do 
        @courses=Course.all 
        erb :"courses/index.html",:locals => {:current_page => "curriculum"}
    end
end