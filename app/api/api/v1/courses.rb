require 'doorkeeper/grape/helpers'

module V1
    class Courses < Grape::API
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
      end

      version 'v1', using: :path
      format :json
      prefix :api
      resource :courses do
        desc 'Return list of Courses'
        get do
          courses = Course.all
          present courses, with: V1::Entities::Course
        end


        desc 'Return a course'
        route_param :id do
          get do
            course = Course.find(params[:id])
            present course, with: V1::Entities::Course
          end
        end

        desc 'Create a course'
          params do
            requires :course_code, type: String
            requires :course_title, type: String
            requires :teacher_id, type: Integer
            requires :semester, type: String
            requires :course_credit, type: Float
            requires :department_id, type: Integer
          end
          post do
            Course.create!({course_title: params[:course_title], course_code: params[:course_code], semester: params[:semseter], course_credit: params[:course_credit].to_f, department_id:params[:department_id], teacher_id:params[:teacher_id]})
          end

        desc 'Delete a course'
        route_param :id do
        delete do
          Course.find(params[:id]).destroy
          end
        end

        desc 'Update a course'
        params do
          requires :id, type: Integer
        end
        put do
          puts params
          Course.find(params[:id]).update(params)
          # Course.create!({course_title: params[:course_title], course_code: params[:course_code], semester: params[:semseter], course_credit: params[:course_credit].to_f, department_id:params[:department_id], teacher_id:params[:teacher_id]})
        end

      end
    end
end