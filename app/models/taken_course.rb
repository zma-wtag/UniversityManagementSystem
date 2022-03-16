class TakenCourse < ApplicationRecord
  belongs_to :student , class_name: 'User', inverse_of: 'student_courses'
  belongs_to :course
end
