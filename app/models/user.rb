class User < ApplicationRecord
  include Clearance::User

  belongs_to :department_head_department ,class_name: 'Department', inverse_of: 'department_head', optional: true
  # Student
  belongs_to :student_department ,class_name: 'Department', inverse_of: 'students' ,optional: true
  has_many :taken_courses, class_name: 'TakenCourse', foreign_key: 'student_id',inverse_of: :student
  has_many :student_courses , class_name:'Course',  through: :taken_courses, source: 'course'
  # Teacher
  belongs_to :teacher_department ,class_name: 'Department', inverse_of: 'teachers' , optional: true
  has_many :teacher_courses, class_name: 'Course', foreign_key: 'teacher_id', inverse_of: :teacher

end
