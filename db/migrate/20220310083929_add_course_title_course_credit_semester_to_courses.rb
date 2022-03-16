class AddCourseTitleCourseCreditSemesterToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :course_title, :string
    add_column :courses, :course_credit, :float
    add_column :courses, :semester, :string
  end
end
