class CompletedCourse
  def self.call(courseList,takenCourses)
    completedCourses = []
    for takenCourse in takenCourses
      if !takenCourse.gpa.nil?
        completedCourses.append(takenCourse.course)
      end
    end
    return courseList-completedCourses
  end
end
