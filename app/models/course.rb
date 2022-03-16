class Course < ApplicationRecord
  has_many :taken_courses
  has_many :students , class_name: 'User' ,through: :taken_courses , foreign_key: 'student_id'
  belongs_to :teacher , class_name: 'User', inverse_of: :teacher_courses
  belongs_to :department
end
