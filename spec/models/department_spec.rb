require 'rails_helper'

RSpec.describe Department, type: :model do
  context 'Validation Test' do
    it 'Ensure department_name presence' do
      course = Department.new().save
      expect(course).to eq(false)
    end

    it 'Ensure creating neew department by passing all validation' do
      course = Department.new(department_name:'testDepartment').save
      expect(course).to eq(true)
    end
  end
end
