class Cgpa
  def self.call(user)
    @user = user
    @cgpa = 0
    @totalCredit = 0
    for takenCourse in @user.taken_courses
      if !takenCourse.gpa.nil?
      @credit =  takenCourse.course.course_credit
      @cgpa+=(TakenCourse.gpas[takenCourse.gpa] * @credit)
      @totalCredit+=@credit
      end
    end
    @cgpa = (@cgpa/@totalCredit).round(2)
  end
end
