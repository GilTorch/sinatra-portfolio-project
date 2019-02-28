class TheAdminsController < ApplicationController 
    get "/admin" do 
        if_is_not_admin_redirect
        
        erb :"admin/index.html",:layout => :admin_layout
    end
end