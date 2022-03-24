module V1
  class Departments < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    resources :departments do
      desc 'fetch all the departments'
      get do
        departments = Department.all
        present departments
      end

    desc 'Return a Department'
    route_param :id do
      get do
        department = Department.find(params[:id])
        present department
      end
    end

      desc 'Create a Departmnet'
      params do
        requires :department_name, type: String
      end
      post do
        Department.create!({department_name: params[:department_name]})
      end

      desc 'Delete a Department'
      route_param :id do
        delete do
          Department.find(params[:id]).destroy
        end
      end

      desc 'Update a Department'
      params do
        requires :id, type: Integer
      end
      put do
        puts params
        Department.find(params[:id]).update(params)
        # Course.create!({course_title: params[:course_title], course_code: params[:course_code], semester: params[:semseter], course_credit: params[:course_credit].to_f, department_id:params[:department_id], teacher_id:params[:teacher_id]})
      end



    end
  end
end