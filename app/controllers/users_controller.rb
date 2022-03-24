class UsersController < Clearance::UsersController
  before_action :create, :only => [:create]
  load_and_authorize_resource
  def index
    @user = current_user
  end

  def edit
    if current_user.role == 'admin'
      redirect_to profile_path, notice: "admin can't update your profile"
    end
    @role = current_user.role
    @departments = Department.all
    @user = current_user
    # @role = 'student'
    # @user = current_user
    # departments = Department.all
    # info =[]
    # departments.each do |department|
    #   info.append([department.department_name,department.id])
    # end
    # @departments = info

  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy()
      redirect_to users_list_path, notice: 'user deleted'
    else
      redirect_to users_list_path, notice: 'user delete failed!'
    end
  end

  def update
    @create_user_params=nil
    @role = params[:user][:role]
    # render json: @role
    if @role =='student'
      @create_user_params = student_params
      # @create_user_params.teacher_department=nil

    elsif @role =='teacher'
      @create_user_params = teacher_params
      # @create_user_params.student_department=nil

    elsif @role =='department_head'
      @create_user_params = department_head_params
      # @create_user_params.student_department=nil
    end
    if current_user.update(@create_user_params)
      redirect_to profile_path, notice: 'Profile Updated !!'
    else
      redirect_to profile_path, notice: 'Profile Update failed!!'
    end
  end


  def update_user_admin
    @user = User.find(params[:id])
    @create_user_params=nil
    @prevrole = @user.role
    @role = params[:user][:role]
    if current_user.role == 'admin' or (current_user.role == 'department_head' and (@user.student_department == current_user.department_head_department or @user.teacher_department == current_user.department_head_department))
      if @role =='student'
        @create_user_params = student_params
        # render json: @create_user_params
        @create_user_params[@role+'_department_id']= params[:user][@prevrole+'_department_id']
        if @prevrole != @role
          @create_user_params[@prevrole+'_department_id'] = nil
        end

      elsif @role =='teacher'
        @create_user_params = teacher_params
        @create_user_params[@role+'_department_id']= params[:user][@prevrole+'_department_id']
        if @prevrole != @role
          if @prevrole != 'department_head'
            @create_user_params[@prevrole+'_department_id'] = nil
          else
            @create_user_params[:role] = 'department_head'
          end
        end
        # render json: @create_user_params
      end
      # render json: @create_user_params
      if @user.update(@create_user_params)
        redirect_to users_list_path, notice: 'User Updated !!'
      else
        redirect_to users_list_path, notice: 'User Update failed!!'
      end
    else
      redirect_to root_path, notice: 'not Authorized'
    end
    # render json: @role

  end

  def new
    if request.path == "/create_student"
      @role = 'student'
    elsif request.path == "/create_teacher"
      @role = 'teacher'
    end
    @user = user_from_params
    if current_user.role == 'admin'
      departments = Department.all
      info =[]
      departments.each do |department|
        info.append([department.department_name,department.id])
      end
      @departments = info
    else
      @departments = [[current_user.department_head_department.department_name,current_user.department_head_department.id]]
    end
    render template: "users/new"
  end


  def create
    # render json: params
    @role = user_params.delete(:role)
    # render json: user_params
    @user = user_from_params
    if @user.save
      redirect_to root_path, notice: "user created"
    else
      redirect_to root_path, notice: 'Failed to create User'
    end
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    phone = user_params.delete(:phone)
    address = user_params.delete(:address)
    name = user_params.delete(:name)

    if @role == 'student'
      student_department = user_params.delete(:student_department)
    elsif @role == 'teacher'
      teacher_department = user_params.delete(:teacher_department)
    end

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
      user.phone = phone
      user.address = address
      user.role = @role
      if !user.email.nil?
        if @role == "student"
          user.student_department = Department.find(student_department)
        elsif @role == "teacher"
          user.teacher_department = Department.find(teacher_department)
        end
      end
    end
  end

  def departmentHeadUpdate
    # render json: params
    @department = Department.find(params[:department_id])
    #
    @user = User.find(params[:department_head_id])
    if !@department.department_head.nil?
      @department.department_head.update({ :department_head_department_id=> nil , role:'teacher' })
    end
    if @user.update({ :department_head_department_id=> @department.id, role:'department_head' })
      redirect_to show_department_path(@department), notice: 'Department head updated'
    else
      redirect_to show_department_path(@department), notice: 'Department head update Failed!!'
    end
  end

  def users_list
    if current_user.role== 'admin'
      @users = User.all
    else
      @teachers = User.where(teacher_department_id:current_user.department_head_department_id)
      @students = User.where(student_department_id:current_user.department_head_department_id)
      @users = @teachers+@students
      @users.delete(current_user)
    end
  end

  def edit_user_admin_and_department_head
    @user = User.find(params[:id])
    @role = @user.role
    @roles = User.roles.keys - ['admin', 'department_head']
    if current_user.role == 'department_head'
      if (@user.role == 'student' and @user.student_department!=current_user.department_head_department) or ((@user.role == 'teacher' or @user.role=='department_head') and current_user.department_head_department != @user.teacher_department)
        redirect_to users_list_path, notice: 'not Authorized'
      else
        @departments = Department.where(id:current_user.department_head_department_id)
        render 'users/edit'
      end
    else
      @departments = Department.all
      render 'users/edit'
    end

    # render json: @roles
    # render json:  @roles.first[0]

  end

  def enroll_course
    @course = Course.find(params[:course_id])
    if current_user.student_courses << @course
      redirect_to courses_path , notice: 'Enrolled'
    else
      redirect_to courses_path , notice: 'Enrollment failed'
    end
  end

  def unenroll_course
    @takencourse = current_user.taken_courses.where(course_id: params[:course_id]).first
    if @takencourse.gpa.nil?
    if TakenCourse.destroy(@takencourse.id)
      redirect_to courses_path , notice: 'Un-Enrolled'
    else
      redirect_to courses_path , notice: 'Un-Enrollment failed'
    end
    else
      redirect_to mycourses_path, notice: 'not authorized'
    end
  end
  def unenroll_by_admin
    @takencourse = TakenCourse.find(params[:course_id])
    if TakenCourse.destroy(@takencourse.id)
      redirect_to courses_path , notice: 'Un-Enrolled'
    else
      redirect_to courses_path , notice: 'Un-Enrollment failed'
    end
  end

  def mycourses
    if current_user.role == 'student'
      @courses = current_user.student_courses
    else
      @courses=current_user.teacher_courses
    end
  end
  def courses_view_admin
    @user = User.find(params[:id])
    if @user.role == 'student'
      @courses = @user.student_courses
    else
      @courses= @user.teacher_courses
    end

    # render json: @courses

    render 'mycourses'
  end

  def addgpa
    @takencourse = TakenCourse.find(params[:taken_course_id])
    @course = @takencourse.course
    @gpa = params[:gpa].to_f
    if @takencourse.update(gpa:@gpa)
      redirect_to mycourse_details_path(@course), notice: 'GPA Updated'
    else
      redirect_to mycourse_details_path(@course), notice: 'GPA Update Failed!'
    end
  end

  def mycourse_details
    # render json: current_user
    @course = Course.find(params[:course_id])
    @gradeList = TakenCourse.gpas
    # render json: @course.taken_courses
  end
  # private
  def redirect_signed_in_users
    #only for overriding
  end
  def student_params
    params.require(:user).permit(:name, :email, :phone, :address, :student_department_id, :role)
  end

  def teacher_params
    params.require(:user).permit(:name, :email, :phone, :address, :teacher_department_id, :role)
  end

  def department_head_params
    params.require(:user).permit(:name, :email, :phone, :address, :teacher_department_id, :role)
  end

end
