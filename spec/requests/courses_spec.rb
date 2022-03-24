require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "Testing Course routes and Controller" do
    before(:each) do
      @user = FactoryBot.build(:student)
      @user.role = 'admin'
      @user.save
      signedIn

      @course1 = FactoryBot.create(:course)
      @course2 = FactoryBot.create(:course)
      @course3 = FactoryBot.create(:course)
    end

    it 'should fetch all the courses' do
      get courses_path
      expect(response.body).to include(@course1.course_code,@course2.course_title, @course3.semester)
    end

    it 'should create a new course' do
      newCourse = FactoryBot.build(:course)
      post create_courses_path, params:{course:{course_code:newCourse.course_code,course_title:newCourse.course_title, teacher_id:newCourse.teacher_id,department_id:newCourse.department_id, semester: newCourse.semester, course_credit:newCourse.course_credit}}
      expect(Course.last.course_title).to eq(newCourse.course_title)
    end

    it 'should update a course' do
      post update_courses_path(@course3), params:{course:{course_title:'Test123'}}
      expect(Course.last.course_code).to eq(@course3.course_code) and expect(Course.last.course_title).to eq('Test123')
    end

    it 'should delete a course' do
      get delete_courses_path(@course3)
      expect(Course.all).not_to include(@course3)
    end

    it 'should update a course from department page' do
      post update_courses_from_department_path(@course3,@course3.department), params:{course:{course_title:'Test123'}}
      expect(Course.last.course_code).to eq(@course3.course_code) and expect(Course.last.course_title).to eq('Test123')
    end

    it 'should delete a course from department page' do
      get delete_courses_from_department_path(@course3,@course3.department)
      expect(Course.all).not_to include(@course3)
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