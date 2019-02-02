class User < ActiveRecord::Base 
    has_secure_password
    validates :username,presence: true
    has_many :user_courses 
    has_many :courses,through: :user_courses
    has_one :role
   

end