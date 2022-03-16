class CreateTakenCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :taken_courses do |t|
      t.references :student
      t.references :course
      t.timestamps
    end
  end
end
