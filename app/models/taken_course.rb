class TakenCourse < ApplicationRecord
  belongs_to :student , class_name: 'User', inverse_of: 'student_courses'
  belongs_to :course

  enum gpa:  { "A":4.0,  "A-":3.7,  "B+":3.3,  "B":3.0, "B-":2.7, "C+":2.3, "C":2.0, "C-":1.7, "D+":1.3, "D":1.0, "D-":1.0, "F":0.0  }
end
