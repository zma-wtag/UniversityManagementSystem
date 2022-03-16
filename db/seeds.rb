d1 = Department.create(department_name:'d1')

['s1','s2'].each do |usr|
  User.create!(name:usr,student_department:d1)
end

['t1','t2'].each do |usr|
  User.create!(name:usr,teacher_department:d1)
end

Course.create(course_code:'c1',teacher:User.first,department:Department.first)