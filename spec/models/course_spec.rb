require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'Validation Test'
  before(:each) do
    @department = Department.create!(department_name:'test')
    @teacher = User.create!(name:'test',password:'test123',address:'test', teacher_department:Department.first,role:'teacher',email:'test@gmail.com',phone:'+8801829723433')
  end
  it 'Ensure course_code presence' do
    course = Course.new(course_title:'test1',course_credit:3.3,teacher:@teacher,department:@department,semester:'test').save
    expect(course).to eq(false)
  end

  it 'Ensure course_title presence' do
    course = Course.new(course_code:'c1',course_credit:3.3,teacher:@teacher,department:@department,semester:'test').save
    expect(course).to eq(false)
  end


  it 'Ensure course_credit presence' do
    course = Course.new(course_title:'test1',course_code:'c1',teacher:@teacher,department:@department,semester:'test').save
    expect(course).to eq(false)
  end

  it 'Ensure semester field presence' do
    course = Course.new(course_title:'test1',course_code:'c1',teacher:@teacher,department:@department).save
    expect(course).to eq(false)
  end

  it 'Ensure saving new course when every validation pass' do
    course = Course.new(course_code:'t01',course_title:'test1',course_credit:3.3,teacher:@teacher,department:@department,semester:'test').save
    expect(course).to eq(true)
  end

end
