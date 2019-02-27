class User < ActiveRecord::Base 
    has_secure_password
    validates :username,presence: true
    has_many :user_lessons 
    has_many :lessons,through: :user_lessons
    has_one :role
end