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
theboss=User.create(username:"boss",password:"1234",password_confirmation:"1234")
theboss.roles << role1