require 'doorkeeper/grape/helpers'
class Base < Grape::API
    helpers Doorkeeper::Grape::Helpers
    before do
        doorkeeper_authorize!
        params.delete(:access_token)
    end
    mount V1::Resources::Courses
    mount V1::Resources::Users
    mount V1::Resources::Departments
end