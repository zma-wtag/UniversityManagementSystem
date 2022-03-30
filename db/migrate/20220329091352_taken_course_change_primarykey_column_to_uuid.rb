class TakenCourseChangePrimarykeyColumnToUuid < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE taken_courses ADD PRIMARY KEY (id);"
  end
end
