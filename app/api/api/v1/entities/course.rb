module V1
  module Entities
    class Course < Grape::Entity
      expose :course_code
      expose :course_title
      expose :semester
      expose :teacher, using: V1::Entities::User
    end
  end
end