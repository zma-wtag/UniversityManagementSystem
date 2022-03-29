class ChangeDepartmentIdTypeToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :departments, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :departments do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE departments ADD PRIMARY KEY (id);"
  end
end
