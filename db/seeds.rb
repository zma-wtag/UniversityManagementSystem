cse = Department.create!(department_name:'CSE')
bba = Department.create!(department_name:'BBA')
ess = Department.create!(department_name:'ESS')

s1 = User.create!(name:'admin',address:'Kakrail',password:'123456',phone:'+8801986542355',email:'admin@gmail.com',role:'admin')

s1 = User.create!(name:'Ryen',address:'Kakrail',password:'123456',phone:'+8801573443221',email:'ryen@gmail.com',role:'student',student_department:cse)
s2 = User.create!(name:'Moin',address:'Basabo',password:'123456', phone:'+8801627344322',email:'moin@gmail.com',role:'student',student_department:cse)
s3 = User.create!(name:'Kaniz',address:'Mirpur',password:'123456',phone:'+8801927344322',email:'kaniz@gmail.com',role:'student',student_department:bba)
s4 = User.create!(name:'Sara',address:'Dhaka',password:'123456',  phone:'+8801856734432',email:'sara@gmail.com',role:'student',student_department:bba)
s5 = User.create!(name:'Hasib',address:"Cox's Bazar",password:'123456',phone:'+8801827344322',email:'hasib@gmail.com',role:'student',student_department:ess)
s6 = User.create!(name:'Ayon',address:'Dhaka',password:'123456',phone:'+8801827344322',email:'ayon@gmail.com',role:'student',student_department:ess)


t1 = User.create!(name:'Orin',address:'Dhaka',password:'123456',  phone:'+8801823344322',email:'orin@gmail.com',role:'teacher',teacher_department:cse)
t2 = User.create!(name:'Rahat',address:'Dhaka',password:'123456', phone:'+8801827844322',email:'rahat@gmail.com',role:'teacher',teacher_department:cse)
t3 = User.create!(name:'Fahim',address:'Dhaka',password:'123456', phone:'+8801828744322',email:'fahim@gmail.com',role:'teacher',teacher_department:bba)
t4 = User.create!(name:'Shuvra',address:'Dhaka',password:'123456',phone:'+8801827344322',email:'shuvra@gmail.com',role:'teacher',teacher_department:bba)
t5 = User.create!(name:'Amit',address:'Dhaka',password:'123456',  phone:'+8801827434322',email:'amit@gmail.com',role:'teacher',teacher_department:ess)
t6 = User.create!(name:'Awon',address:'Dhaka',password:'123456',  phone:'+8801827564322',email:'awon@gmail.com',role:'teacher',teacher_department:ess)


c1 = Course.create!(course_code:'CSE110', course_title:'Programming Language 1', course_credit:3.0, semester:'spring22', department:cse, teacher:t1)
c1 = Course.create!(course_code:'CSE111', course_title:'Programming Language 2', course_credit:3.0, semester:'spring22', department:cse, teacher:t2)
c1 = Course.create!(course_code:'CSE220', course_title:'Data Structure', course_credit:3.0, semester:'spring22', department:cse, teacher:t1)
c1 = Course.create!(course_code:'CSE221', course_title:'Algorithm', course_credit:3.0, semester:'spring22', department:cse, teacher:t2)
c1 = Course.create!(course_code:'BUS201', course_title:'Introduction to Business', course_credit:3.0, semester:'spring22', department:bba, teacher: t3)
c1 = Course.create!(course_code:'BUS203', course_title:'Business 2', course_credit:3.0, semester:'spring22', department:bba, teacher: t4)
c1 = Course.create!(course_code:'BUS405', course_title:'Business Logic', course_credit:3.0, semester:'spring22', department:bba, teacher: t4)
c1 = Course.create!(course_code:'ANT101', course_title:'Introduction To Anthropology', course_credit:3.0, semester:'spring22', department:ess, teacher: t5)
c1 = Course.create!(course_code:'SOC102', course_title:'Introduction To Sociology', course_credit:3.0, semester:'spring22', department:ess, teacher: t5)
c1 = Course.create!(course_code:'ECO101', course_title:'Introduction To Economics', course_credit:3.0, semester:'spring22', department:ess, teacher: t6)