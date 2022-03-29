class CourseChangeColumnsToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :uuid1, :uuid, default: "gen_random_uuid()", null: false
    add_column :courses, :uuid2, :uuid, default: "gen_random_uuid()", null: false

    change_table :courses do |t|
      t.remove :teacher_id
      t.remove :department_id
      t.rename :uuid1, :teacher_id
      t.rename :uuid2, :department_id
    end
  end
end
