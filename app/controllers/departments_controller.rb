class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end
  def new
    @department = Department.new
    @departmentHeads = User.where.not(department_head_department_id:nil)
    # render json: @departmentHeads

  end

  def store
    @department = Department.new(department_params)
    # render json: @department
    if @department.save
      redirect_to departments_path , notice: 'Department Created!! '
    else

    end
  end

  def show
    @department = Department.find(params[:id])
    @students = @department.students
    @teachers = @department.teachers
    @courses = @department.courses
  end

  def edit
    @department = Department.find(params[:id])
    @departmentHeads = User.where.not(department_head_department_id:nil)
    render 'departments/new'
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to departments_path, notice: 'Update saved!'
    else
      redirect_to departments_path, notice: 'Update failed!'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    if @department.destroy
      redirect_to departments_path, notice: 'department Deleted!'
    else
      redirect_to departments_path, notice: 'Unable to delete Department!'
    end
  end

  private
  def department_params
    params.require(:department).permit(:department_name)
  end
end
