# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :grade_sheet, User
    can :index, Course
    can :mycourses, User
    can :mycourse_details , User
    if user.role == 'admin'
      can :manage, :all
      cannot :edit, User
    end

    if user.role == 'department_head' or user.role == 'student'
      can :read, :all
      can :edit, User
      can :update, User
      can :mycourses, User
      can :mycourse_details, User
    end

    if user.role == 'department_head'
      # course
      can :new, Course
      can :create, Course
      can :update, Course
      can :destroy, Course

      # User
      can :new, User
      can :create, User
      can :edit_user_admin_and_department_head, User
      can :users_list, User
      can :update_user_admin, User
      can :student_params, User
      can :teacher_params, User
      can :department_head_params, User
      can :user_from_params, User
      can :courses_view_admin, User
      can :mycourse_details, User
      can :unenroll_by_admin, User
      can :addgpa, User
      can :show_teacher, Department




    end

    if user.role == 'student'
      can :enroll_course, User
      can :unenroll_course, User
      can :show_teacher, Department
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
