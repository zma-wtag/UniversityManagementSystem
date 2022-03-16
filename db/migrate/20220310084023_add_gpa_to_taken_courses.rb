class AddGpaToTakenCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :taken_courses, :gpa, :float
    add_column :taken_courses, :semester, :string
  end
end
