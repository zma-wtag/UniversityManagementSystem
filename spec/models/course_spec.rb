require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'Validation Test'
  let(:course) {FactoryBot.build(:course)}
  it 'Ensure course_code presence' do
    course.course_code = nil
    expect(course.save).to eq(false)
  end

  it 'Ensure course_title presence' do
    course.course_title = nil
    expect(course.save).to eq(false)
  end


  it 'Ensure course_credit presence' do
    course.course_credit = nil
    expect(course.save).to eq(false)
  end

  it 'Ensure semester field presence' do
    course.semester = nil
    expect(course.save).to eq(false)
  end

  it 'Ensure saving new course when every validation pass' do
    expect(course.save).to eq(true)
  end

end
