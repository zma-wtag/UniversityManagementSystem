class Department < ApplicationRecord
  has_one :department_head, class_name: 'User', inverse_of: :department_head_department, foreign_key: :department_head_department_id
  has_many  :students, class_name: 'User', inverse_of: 'student_department',foreign_key: 'student_department_id'
  has_many  :teachers, class_name: 'User', inverse_of: 'teacher_department',foreign_key: 'teacher_department_id'
  has_many  :courses

  validates :department_name, presence: true
end
