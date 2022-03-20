# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_03_16_045737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "course_code"
    t.bigint "teacher_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course_title"
    t.float "course_credit"
    t.string "semester"
    t.index ["department_id"], name: "index_courses_on_department_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taken_courses", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "gpa"
    t.string "semester"
    t.index ["course_id"], name: "index_taken_courses_on_course_id"
    t.index ["student_id"], name: "index_taken_courses_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "student_department_id"
    t.bigint "teacher_department_id"
    t.bigint "department_head_department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "address"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.integer "role", default: 0
    t.index ["department_head_department_id"], name: "index_users_on_department_head_department_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["student_department_id"], name: "index_users_on_student_department_id"
    t.index ["teacher_department_id"], name: "index_users_on_teacher_department_id"
  end

end
