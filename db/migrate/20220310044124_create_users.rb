class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.references :student_department
      t.references  :teacher_department
      t.references  :department_head_department
      t.timestamps
    end
  end
end
