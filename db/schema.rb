# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_19_002109) do

  create_table "groups", force: :cascade do |t|
    t.integer "index"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "user_id"
    t.integer "word_id"
    t.integer "q_a_ok"
    t.integer "q_a_ng"
    t.integer "a_q_ok"
    t.integer "a_q_ng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scores_on_user_id"
    t.index ["word_id"], name: "index_scores_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.integer "wordset_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index"
    t.index ["wordset_id"], name: "index_words_on_wordset_id"
  end

  create_table "wordsets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index"
    t.integer "group_id"
    t.index ["group_id"], name: "index_wordsets_on_group_id"
  end

end
