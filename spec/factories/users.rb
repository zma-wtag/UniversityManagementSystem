FactoryBot.define do
  factory :student, class:'User' do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {'123456'}
  student_department {FactoryBot.create(:department)}
    phone {'+8801726984256'}
    address {Faker::Address.street_name}
    role {'student'}
  end


  factory :teacher, class:'User' do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {'123456'}
    teacher_department {FactoryBot.create(:department)}
    phone {'+8801726984256'}
    address {Faker::Address.street_name}
    role {'teacher'}
  end


  factory :department_head, class:'User' do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {'123456'}
    department_head_department {FactoryBot.create(:department)}
    phone {'+8801726984256'}
    address {Faker::Address.street_name}
    role {'department_head'}
  end
end