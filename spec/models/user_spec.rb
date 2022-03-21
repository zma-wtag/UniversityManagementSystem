require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do

    it 'Ensure name presence' do
      user = User.new(email:'test@gmail.com',password:'123456',phone:'+880182234234', address:'Dhaka').save
      expect(user).to eq(false )
    end

    it 'Ensure email presence' do
      user = User.new(name:'test',password:'123456',phone:'+880182234234', address:'Dhaka').save
      expect(user).to eq(false )
    end

    it 'Ensure Phone presence' do
      user = User.new(name:'test', email:'test@gmail.com',password:'123456', address:'Dhaka').save
      expect(user).to eq(false )
    end

    it 'Ensure address presence' do
      user = User.new(name:'test', email:'test@gmail.com',password:'123456',phone:'+880182234234').save
      expect(user).to eq(false )
    end

    it 'Ensure Unique Email' do
      user1 = User.new(name:'test', email:'test@gmail.com',password:'123456',phone:'+880182234234', address:'Dhaka').save
      user2 = User.new(name:'test', email:'test@gmail.com',password:'123456',phone:'+880182234234', address:'Dhaka').save
      expect(user1).to eq(true) and expect(user2).to eq(false)
    end


    it 'Ensure saved successfully' do
      user = User.new(name:'test', email:'test@gmail.com',password:'123456',phone:'+880182234234', address:'Dhaka').save
      expect(user).to eq(true)
    end

  end

  context 'checking different roled users' do
    let (:params) {{name:'test',password:'123456',phone:'+880182234234', address:'Dhaka'}}

    before(:each) do
      User.new(params.merge(email:'test1@gmail.com')).save
      User.new(params.merge(email:'test2@gmail.com')).save
      User.new(params.merge(email:'test3@gmail.com',role:'teacher')).save
      User.new(params.merge(email:'test4@gmail.com',role:'department_head')).save
      User.new(params.merge(email:'test5@gmail.com',role:'department_head')).save
      User.new(params.merge(email:'test6@gmail.com',role:'admin')).save
    end
    it 'should return user who are student' do
      expect(User.where(role:'student').size).to eq(2)
    end

    it 'should return user who are teacher' do
      expect(User.where(role:'teacher').size).to eq(1)
    end


    it 'should return user who are department_head' do
      expect(User.where(role:'department_head').size).to eq(2)
    end

    it 'should return user who are admin' do
      expect(User.where(role:'admin').size).to eq(1)
    end

  end

  context 'checking Students and Teachers course funcionality' do
    department = Department.create!(department_name:'testDepartment')
    before(:each) do
      @teacher = User.create!(name:'testTeacher',password:'test123',address:'test', teacher_department:department,role:'teacher',email:'testTeacher@gmail.com',phone:'+8801829723433')
      @student = User.create!(name:'testStudent',password:'test123',address:'test', student_department:department,role:'student',email:'testStudent@gmail.com',phone:'+8801829723433')
      @course = Course.create!(course_code:'t01',course_title:'testCourse',course_credit:3.3,teacher:@teacher,department:department,semester:'test')
    end

    it 'should return Student taken course' do
      @student.student_courses.push(@course)
      expect(@student.taken_courses.first.course).to eq(@course)
    end

    it "should return teacher's assign course" do
      expect(@teacher.teacher_courses.first).to eq(@course)
    end


  end
end
