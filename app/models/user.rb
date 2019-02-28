class User < ActiveRecord::Base 
    has_secure_password
    validates :username,presence: true

    has_many :user_lessons 
    has_many :lessons,through: :user_lessons

    has_many :user_roles 
    has_many :roles,:through => :user_roles
    
    def initialize(args)
        super(args)
        roles << Role.find_by(label:"trainee")
    end
end