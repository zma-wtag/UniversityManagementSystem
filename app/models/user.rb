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

  enum role: %i(student teacher department_head admin)

  validates :name , presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :phone , presence: true
  validates :role , presence: true
  validates_plausible_phone :phone, presence: true
  validates :email, presence: true, 'valid_email_2/email': { message: 'Invalid email provided' }
  private

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
end
