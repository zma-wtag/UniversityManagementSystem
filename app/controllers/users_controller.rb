class UsersController < Clearance::UsersController
  def index
    @user = current_user
  end

  def edit
    @role = "teacher"
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

  def update
    @create_user_params=nil
    @role = params[:user][:role]
    # render json: @role
    if @role =='student'
      @create_user_params = student_params

    elsif @role =='teacher'
      @create_user_params = teacher_params
    end
    if current_user.update(student_params)
      redirect_to profile_path, notice: 'Profile Updated !!'
    else
      redirect_to profile_path, notice: 'Profile Update failed!!'
    end
  end

  def new
    if request.path == "/create_student"
      @role = 'student'
    elsif request.path == "/create_teacher"
      @role = 'teacher'
    end
    @user = user_from_params
    departments = Department.all
    info =[]
    departments.each do |department|
      info.append([department.department_name,department.id])
    end
    @departments = info
    render template: "users/new"
  end


  def create
    # render json: params
    @role = user_params.delete(:role)
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
      @department.department_head.update({ :department_head_department_id=> nil })
    end
    if @user.update({ :department_head_department_id=> @department.id })
      redirect_to show_department_path(@department), notice: 'Department head updated'
    else
      redirect_to show_department_path(@department), notice: 'Department head update Failed!!'
    end
  end

  private
  def student_params
    params.require(:user).permit(:name, :email, :phone, :address, :student_department_id)
  end

  def teacher_params
    params.require(:user).permit(:name, :email, :phone, :address, :teacher_department_id)
  end

  def department_head_params
    params.require(:user).permit(:department_head_department_id)
  end


end
