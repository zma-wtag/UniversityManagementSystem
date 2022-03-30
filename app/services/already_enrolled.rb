class AlreadyEnrolled
  def self.call(userCourses,course)
    for userCourse in userCourses
      if userCourse.course == course
        return true
      end
    end
    false
  end
end