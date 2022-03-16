class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_code
      t.references :teacher
      t.references :department
      t.timestamps
    end
  end
end
