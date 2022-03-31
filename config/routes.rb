Rails.application.routes.draw do
  use_doorkeeper
  mount Base => '/'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end


  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/create_student/" => "users#new", as: "create_student"
  get "/create_teacher" => "users#new", as: "create_teacher"
  get "/create_api_user" => "users#new", as: "create_api_user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root 'courses#index'
  get '/courses', to: 'courses#index', as: 'courses'
  get '/create_courses', to: 'courses#new', as: 'create_courses'
  get 'course/:id', to: 'courses#show', as: 'show_courses'
  post '/create_courses', to: 'courses#create', as: 'store_courses'
  post 'course/:id/update', to: 'courses#edit', as: 'update_courses'
  get 'course/:id/delete', to: 'courses#destroy', as: 'delete_courses'
  #
  # Department Routes
  #
  get 'departments', to: 'departments#index', as: 'departments'
  get 'create/department', to: 'departments#new', as: 'create_departments'
  post 'create/department', to: 'departments#store', as: 'store_department'
  get 'department/:id/view', to: 'departments#show', as: 'show_department'
  get 'department/:id/edit', to: 'departments#edit', as: 'edit_department'
  post 'department/:id/edit', to: 'departments#update', as: 'update_department'
  get 'department/:id/destroy', to: 'departments#destroy', as: 'destroy_department'
  post 'course/:id/update/:dptid', to: 'courses#edit_from_department', as: 'update_courses_from_department'
  get 'course/:id/department/:dptid', to: 'courses#show_from_department', as: 'show_courses_department'
  get 'course/:id/delete/department/:dptid', to: 'courses#destroy_from_department', as: 'delete_courses_from_department'
  get 'teacher/:teacher_id/view', to: 'departments#show_teacher', as: 'show_teacher'

  # Users

  get 'profile', to: 'users#index', as: 'profile'
  get '/edit', to: 'users#edit', as: 'profile_edit_page'
  post '/edit', to: 'users#update', as: 'profile_update'
  post 'departmenthead', to: 'users#departmentHeadUpdate', as: 'department_head_update'
  get '/users', to: 'users#users_list', as: 'users_list'
  get '/user/:id', to: 'users#edit_user_admin_and_department_head', as: 'edit_user_admin'
  post '/user/:id', to: 'users#update_user_admin', as: 'update_user_admin'
  get 'mycourses', to: 'users#mycourses' , as:'mycourses'
  get 'mycourse/:course_id/details' , to: 'users#mycourse_details' , as: 'mycourse_details'
  get 'courses/user/:id', to: 'users#courses_view_admin', as: 'courses_list_user'
  get 'delete/user/:id', to: 'users#destroy', as: 'delete_user'
  get 'user/grade/:id', to: 'users#grade_sheet', as: 'user_grade'
  get 'user/profile/:id', to: 'users#viewedByOthers', as: 'viewed_by_others'
  get 'user_api/:id', to: 'users#api_user_home', as: 'api_user_home'
  get 'token_generate', to: 'users#create_api_token', as: 'api_token_generate'

  # enroll course
  get 'enroll/:course_id', to: 'users#enroll_course', as: 'enroll_course'
  get 'unenroll/:course_id', to: 'users#unenroll_course', as: 'unenroll_course'
  get 'unenroll/byadmin/:course_id', to: 'users#unenroll_by_admin', as: 'unenroll_by_admin'
  #add GPA
  post 'addgpa/:taken_course_id', to: 'users#addgpa', as: 'add_gpa'
end
