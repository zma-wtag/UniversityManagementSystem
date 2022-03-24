require 'rails_helper'

RSpec.describe "Departments", type: :request do
  describe "Testing Route and Controller" do
    before(:each) do
      @user = FactoryBot.build(:student)
      @user.role = 'admin'
      @user.save
      signedIn
      @department1 = FactoryBot.create(:department)
      @department2 = FactoryBot.create(:department)
      @department3 = FactoryBot.create(:department)
    end
    it 'should Fetch all the department info' do
      get departments_path
      expect(response.body).to include(@department1.department_name,@department2.department_name,@department3.department_name)
    end

    it 'should store a department in DB' do
      post create_departments_path, params:{department:{department_name:'Testing Store'}}
      expect(Department.last.department_name).to eq('Testing Store')
    end

    it 'should destroy a department from DB' do
      last_dept = Department.last
      get destroy_department_path(@department3)
      expect(last_dept).to eq(@department3) and expect(Department.last).not_to eq(@department3)
    end

    it 'should update department name' do
      post update_department_path(@department3), params:{department:{department_name:'testing'}}
      expect(Department.last.department_name).to eq('testing')
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