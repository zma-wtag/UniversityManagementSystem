class ChangeCourseIdTypeToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :courses do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE courses ADD PRIMARY KEY (id);"
  end
end
