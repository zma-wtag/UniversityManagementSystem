require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    let (:student) {FactoryBot.build(:student)}
    let (:teacher) {FactoryBot.build(:teacher)}
    let (:department_head) {FactoryBot.build(:department_head)}
    it 'Ensure name presence' do
      student.name = nil
      # puts student
      expect(student.save).to eq(false)
    end

    it 'Ensure email presence' do
      teacher.email = nil
      expect(teacher.save).to eq(false)
    end

    it 'Ensure Phone presence' do
      department_head.phone = nil
      expect(department_head.save).to eq(false)
    end

    it 'Ensure address presence' do
      teacher.address = nil
      expect(teacher.save).to eq(false)
    end

    it 'Ensure Unique Email' do
      user1 = student
      user2 = teacher
      user2.email = user1.email
      expect(user1.save).to eq(true) and expect(user2.save).to eq(false)
    end


    it 'Ensure saved successfully' do
      expect(student.save).to eq(true)
    end

  end

  context 'checking different roled users' do

    before(:each) do
      FactoryBot.create(:student)
      FactoryBot.create(:student)
      FactoryBot.create(:teacher)
      FactoryBot.create(:department_head)
      FactoryBot.create(:department_head)
      admin = FactoryBot.build(:teacher)
      admin.role = 'admin'
      admin.save
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
    before(:each) do
      @department = FactoryBot.create(:department)
      @teacher = User.create!(name:'testTeacher',password:'test123',address:'test', teacher_department:@department,role:'teacher',email:'testTeacher@gmail.com',phone:'+8801829723433')
      @student = User.create!(name:'testStudent',password:'test123',address:'test', student_department:@department,role:'student',email:'testStudent@gmail.com',phone:'+8801829723433')
      @course = Course.create!(course_code:'t01',course_title:'testCourse',course_credit:3.3,teacher:@teacher,department:@department,semester:'test')
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
