course1=Course.create(title:'HTML & CSS')

course1chapter1=Chapter.create(title:"The selectors")
course1.chapters << course1chapter1
course1chapter1lesson1=Lesson.create(title:"How to select by id",content:"To select by id you must...")
course1chapter1.lessons << course1chapter1lesson1

course1chapter2=Chapter.create(title:"Learn about tags")
course1.chapters << course1chapter2
course1chapter2lesson1=Lesson.create(title:"The <p> tag",content:"The p tag is for a block of text...")
course1chapter2.lessons << course1chapter2lesson1

course1chapter3=Chapter.create(title:"The Head section")
course1.chapters << course1chapter3 
course1chapter3lesson1=Lesson.create(title:"How to select by id",content:"To select by id you must...")
course1chapter3.lessons << course1chapter3lesson1


role1=Role.create(label:"admin")
role2=Role.create(label:"trainer")
role3=Role.create(label:"trainee")
theboss=User.create(username:"boss",email:'user1@gmail.com',password:"1234",password_confirmation:"1234")
theboss.roles << role1

user1=User.create(username:"user1",email:'user1@gmail.com',password:"1234",password_confirmation:"1234")
user2=User.create(username:"user2",email:'user2@gmail.com',password:"1234",password_confirmation:"1234")
user3=User.create(username:"user3",email:'user3@gmail.com',password:"1234",password_confirmation:"1234")
user4=User.create(username:"user4",email:'user4@gmail.com',password:"1234",password_confirmation:"1234")
user5=User.create(username:"user5",email:'user5@gmail.com',password:"1234",password_confirmation:"1234")
user6=User.create(username:"user6",email:'user6@gmail.com',password:"1234",password_confirmation:"1234")
user7=User.create(username:"user7",email:'user7@gmail.com',password:"1234",password_confirmation:"1234")
user8=User.create(username:"user8",email:'user8@gmail.com',password:"1234",password_confirmation:"1234")
user9=User.create(username:"user9",email:'user9@gmail.com',password:"1234",password_confirmation:"1234")
user10=User.create(username:"user10",email:'user10@gmail.com',password:"1234",password_confirmation:"1234")
user11=User.create(username:"user11",email:'user11@gmail.com',password:"1234",password_confirmation:"1234")
user12=User.create(username:"user12",email:'user12@gmail.com',password:"1234",password_confirmation:"1234")
user13=User.create(username:"user13",email:'user13@gmail.com',password:"1234",password_confirmation:"1234")
user14=User.create(username:"user14",email:'user14@gmail.com',password:"1234",password_confirmation:"1234")
user15=User.create(username:"user15",email:'user15@gmail.com',password:"1234",password_confirmation:"1234")
user16=User.create(username:"user16",email:'user16@gmail.com',password:"1234",password_confirmation:"1234")
user17=User.create(username:"user17",email:'user17@gmail.com',password:"1234",password_confirmation:"1234")
user18=User.create(username:"user18",email:'user18@gmail.com',password:"1234",password_confirmation:"1234")
user19=User.create(username:"user19",email:'user19@gmail.com',password:"1234",password_confirmation:"1234")
user20=User.create(username:"user20",email:'user20@gmail.com',password:"1234",password_confirmation:"1234")