require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Testing User Controller" do
    before(:each) do
      @user = FactoryBot.build(:student)
      @user.role = 'admin'
      @user.save
      @department = FactoryBot.create(:department)
    end
    it "get all users without signin" do
      get users_path
      expect(response).to redirect_to(sign_in_path)
    end

    it 'should Log in user' do
      signedIn
      get users_path
      # puts response.status
      expect(response.body).to include(@user.name)
    end

    it 'should create a new student' do
      signedIn
      @newUser = {"email":"adfawef@gmail.com","password":"123456","name":"student1","address":"Dhaka","phone":"+8801726234423","student_department":Department.last.id,role:'student'}
      post users_path, params:{user:@newUser}
      expect(User.last.email).to eq(@newUser[:email])
    end


    it 'should create a new teacher' do
      signedIn
      @newUser = {"email":"adfawef@gmail.com","password":"123456","name":"teacher1","address":"Dhaka","phone":"+8801726234423","teacher_department":Department.last.id,role:'teacher'}
      post users_path, params:{user:@newUser}
      expect(User.last.email).to eq(@newUser[:email])
    end

    it 'should assign Department Head' do
      signedIn
      @teacher = FactoryBot.build(:teacher)
      @teacher.save
      @department = @teacher.teacher_department
      post department_head_update_path, params:{department_head_id:@teacher.id,department_id:@department.id}
      expect(Department.find(@department.id).department_head).to eq(@teacher) and expect(flash[:notice]).to eq('Department head updated')
    end


    it 'should change Department Head of a Department' do
      signedIn
      @teacher1 = FactoryBot.build(:teacher)
      @teacher2 = FactoryBot.build(:teacher)
      @teacher2.teacher_department = @teacher1.teacher_department
      @teacher1.save
      @teacher2.save
      @department = @teacher1.teacher_department
      post department_head_update_path, params:{department_head_id:@teacher1.id,department_id:@department.id}
      post department_head_update_path, params:{department_head_id:@teacher2.id,department_id:@department.id}
      expect(Department.find(@department.id).department_head).to eq(@teacher2) and expect(User.find(@teacher1.id).department_head_department).to eq(nil) and expect(User.find(@teacher1.id).role).to eq('teacher')
    end

    it 'should student enrolling in a course' do
      signedInWithRole('student')
      @course = FactoryBot.create(:course)
      get enroll_course_path(@course)
      expect(User.find(@randomUser.id).student_courses.first).to eq(@course)
    end

    it 'should student Un-enroll from a course' do
      signedInWithRole('student')
      @course = FactoryBot.create(:course)
      get enroll_course_path(@course)
      @enrolled = User.find(@randomUser.id).student_courses.first
      get unenroll_course_path(@course)
      expect(@enrolled).to eq(@course) and expect(User.find(@randomUser.id).student_courses).not_to include(@course)
    end

    it 'should add gpa to a Student_Course' do
      signedInWithRole('student')
      @course = FactoryBot.create(:course)
      get enroll_course_path(@course)
      @enrolled = User.find(@randomUser.id).taken_courses.first
      delete sign_out_path
      signedIn
      post add_gpa_path(@enrolled), params:{gpa:4.0}
      expect(@course.taken_courses.first.gpa).to eq(@randomUser.taken_courses.first.gpa)
    end

  end
end

def signedIn
  post session_path, params:{session:{email:@user.email, password:'123456'}}
end

def signedInWithRole(role)
  @randomUser = FactoryBot.create(role)
  post session_path, params:{session:{email:@randomUser.email, password:'123456'}}
end
