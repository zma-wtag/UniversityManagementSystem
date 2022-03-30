class TakenCourseChangeIdColumnToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :taken_courses, :uuid1, :uuid, default: "gen_random_uuid()", null: false

    change_table :taken_courses do |t|
      t.remove :id
      t.rename :uuid1, :id
    end
  end
end
