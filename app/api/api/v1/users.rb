module V1
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
    end
  end
end