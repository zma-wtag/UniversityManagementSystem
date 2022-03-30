class Cgpa
  def self.call(user)
    @user = user
    @cgpa = 0.00
    @totalCredit = 0
    @attemptedCredit = 0
    for takenCourse in @user.taken_courses
      @credit =  takenCourse.course.course_credit
      if !takenCourse.gpa.nil?
      @cgpa+=(TakenCourse.gpas[takenCourse.gpa] * @credit)
      @totalCredit+=@credit
      end
      @attemptedCredit+= @credit
    end
    if @cgpa > 0
      @cgpa = (@cgpa/@totalCredit).round(2)
    end
    return {
      'cgpa':@cgpa,
      'totalCredit': @totalCredit,
      'attemptedCredit': @attemptedCredit
    }
  end
end
