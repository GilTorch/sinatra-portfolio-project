class Course < ActiveRecord::Base 
    has_many :user_courses 
    has_many :users,through: :courses 
    has_many :chapters
end