FactoryBot.define do
  factory :course do
    course_title {Faker::Name.name}
    department {FactoryBot.create(:department)}
    teacher {FactoryBot.create(:teacher)}
    course_code {Faker::Science.element_symbol}
    semester {Faker::Science.modifier}
    course_credit {Faker::Number.decimal(l_digits: 1, r_digits:1)}
  end
end