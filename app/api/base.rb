class Base < Grape::API
    mount V1::Courses
    mount V1::Users
    mount V1::Departments
end