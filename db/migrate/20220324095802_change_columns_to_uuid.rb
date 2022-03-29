class ChangeColumnsToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uuid1, :uuid, default: "gen_random_uuid()"
    add_column :users, :uuid2, :uuid, default: "gen_random_uuid()"
    add_column :users, :uuid3, :uuid, default: "gen_random_uuid()"

    change_table :users do |t|
      t.remove :student_department_id
      t.remove :teacher_department_id
      t.remove :department_head_department_id
      t.rename :uuid1, :student_department_id
      t.rename :uuid2, :teacher_department_id
      t.rename :uuid3, :department_head_department_id
    end
  end
end
