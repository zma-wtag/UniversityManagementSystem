module V1
  module Resources
  class Users < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    resources :users do
      desc 'fetch all the users'
      get do
        users = User.all
        present users
      end

    desc 'Return a User'
    route_param :id do
      get do
        user = User.find(params[:id])
        present user, with: V1::Entities::User
      end
    end

      desc 'Create a User'
      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :phone, type: String
        requires :address, type: String
        requires :role, type: String
      end
      post do
        if params[:role] == 'admin'
          return {'error': 'not Authorized!'}
        end
        puts params
        # return params
        User.create!(params)
      end


      desc 'Delete a User'
      route_param :id do
        delete do
          @user = User.find(params[:id])
          if @user.role == 'admin'
            return {'error': 'not Authorized!'}
          end
          @user.destroy
        end
      end

      desc 'Update a User'
      params do
        requires :id, type: String
      end
      put do
        if params[:role] == 'admin'
          return {'error': 'not Authorized!'}
        end
        puts params
        User.find(params[:id]).update(params)
        # Course.create!({course_title: params[:course_title], course_code: params[:course_code], semester: params[:semseter], course_credit: params[:course_credit].to_f, department_id:params[:department_id], teacher_id:params[:teacher_id]})
      end


    end
    end
  end
end