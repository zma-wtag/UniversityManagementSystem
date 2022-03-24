module V1
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :phone
      expose :teacher_department_id
      expose :student_department_id
      expose :department_head_department_id
      expose :student_course_ids
      expose :teacher_course_ids
      expose :role
    end
  end
end