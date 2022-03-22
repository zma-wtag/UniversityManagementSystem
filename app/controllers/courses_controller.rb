class CoursesController < ApplicationController
  load_and_authorize_resource
  def index
    @courses = Course.all
    if signed_in? and current_user.role =='student'
      @mycourses = current_user.student_courses
    end
    # render json: @mycourses
    # @teachers = User.where.not(teacher_department_id:nil)
    # render json: @courses

  end
  def new
    if current_user.role == 'admin'
      @teachers = User.where.not(teacher_department_id:nil)
      @departments = Department.all
    elsif current_user.role == 'department_head'
      @teachers = User.where(teacher_department_id:current_user.department_head_department.id)
      @departments = [current_user.department_head_department]
    end
    @course = Course.new()
    # render json: current_user.department_head_department
  end

  def create
    # render json: params[:course]
    @course = Course.new(course_params)
    if current_user.role == 'department_head' and @course.department != current_user.department_head_department
      redirect_to create_courses_path, notice: 'not Authorized!!'
    # render json: @course
    elsif @course.save
      redirect_to courses_path , :notice => 'Your course was saved'
    else
      render "new"
    end
  end

  def edit
    @course = Course.find(params[:id])
    if current_user.role == 'department_head' and @course.department != current_user.department_head_department
      redirect_to courses_path, notice: 'not Authorized!!'
    elsif @course.update(course_params)
      redirect_to courses_path, notice:'Changes Saved!'
    else
      redirect_to courses_path, notice: 'Failed to save Changes!!'
    end
  end


  def edit_from_department
    @course = Course.find(params[:id])
    if current_user.role == 'department_head' and @course.department != current_user.department_head_department
      redirect_to show_department_path(params[:dptid]), notice: 'not Authorized!!'
      elsif @course.update(course_params)
      redirect_to show_department_path(params[:dptid]), notice: 'Course Updated'
    else
      redirect_to show_department_path(params[:dptid]), notice: 'Failed to save Changes!!'
    end
  end
  def show
    if current_user.role == 'admin'
    @course = Course.find(params[:id])
    @teachers = User.where.not(teacher_department_id:nil)
    @departments = Department.all
    else
      @course = Course.find(params[:id])
      @teachers = User.where(teacher_department_id:@course.department_id)
      @departments = Department.where(id:@course.department_id)
    end
    render "new"
  end

  def show_from_department
    @course = Course.find(params[:id])
    @teachers = User.where.not(teacher_department_id:nil)
    @departments = Department.all
    @dptid=params[:dptid]
    render "new"
  end

  def destroy_from_department
    @course = Course.find(params[:id])
    if current_user.role == 'department_head' and @course.department != current_user.department_head_department
      redirect_to show_department_path(params[:dptid]), notice: 'not Authorized!!'
    elsif @course.destroy
      redirect_to show_department_path(params[:dptid]), notice: 'Course Deleted!'
    else
      redirect_to show_department_path(params[:dptid]), notice: 'Course Delete failed !!'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if current_user.role == 'department_head' and @course.department != current_user.department_head_department
      redirect_to courses_path, notice: 'not Authorized!!'
    elsif @course.destroy
      redirect_to courses_path, notice: 'Course Deleted!'
    else
      redirect_to courses_path, notice: 'Course Delete failed !!'
    end
  end

  private

  def course_params
    params.require(:course).permit(:course_code, :course_title, :teacher_id, :department_id, :semester, :course_credit)
  end
end
