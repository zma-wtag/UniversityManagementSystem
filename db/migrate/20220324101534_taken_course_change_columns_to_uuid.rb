class TakenCourseChangeColumnsToUuid < ActiveRecord::Migration[7.0]
  def change
      add_column :taken_courses, :uuid1, :uuid, null: false
      add_column :taken_courses, :uuid2, :uuid, null: false

      change_table :taken_courses do |t|
        t.remove :student_id
        t.remove :course_id
        t.rename :uuid1, :student_id
        t.rename :uuid2, :course_id
      end
  end
end
