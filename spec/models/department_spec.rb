require 'rails_helper'

RSpec.describe Department, type: :model do
  let(:department) {FactoryBot.build(:department)}
  context 'Validation Test' do
    it 'Ensure department_name presence' do
      department.department_name = nil
      expect(department.save).to eq(false)
    end

    it 'Ensure creating neew department by passing all validation' do
      expect(department.save).to eq(true)
    end
  end
end
