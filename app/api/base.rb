class Base < Grape::API
    mount V1::Courses
    mount V1::Users
end