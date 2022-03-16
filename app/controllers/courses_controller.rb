class CoursesController < ApplicationController
  def index
    @courses = Course.all
    # @teachers = User.where.not(teacher_department_id:nil)
    # render json: @courses

  end
  def new
    @teachers = User.where.not(teacher_department_id:nil)
    @departments = Department.all
    @course = Course.new()
  end

  def create
    # render json: params[:course]
    @course = Course.new(course_params)
    # render json: @course
    if @course.save
      redirect_to courses_path , :notice => 'Your course was saved'
    else
      render "new"
    end
  end

  def edit
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to courses_path, notice:'Changes Saved!'
    else
      redirect_to courses_path, notice: 'Failed to save Changes!!'
    end
  end


  def edit_from_department
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to show_department_path(params[:dptid]), notice: 'Course Updated'
    else
      redirect_to show_department_path(params[:dptid]), notice: 'Failed to save Changes!!'
    end
  end
  def show
    @course = Course.find(params[:id])
    @teachers = User.where.not(teacher_department_id:nil)
    @departments = Department.all
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
    if @course.destroy
      redirect_to show_department_path(params[:dptid]), notice: 'Course Deleted!'
    else
      redirect_to show_department_path(params[:dptid]), notice: 'Course Delete failed !!'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
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
