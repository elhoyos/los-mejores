# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160326235454) do

  create_table "automoviles", force: :cascade do |t|
    t.string   "placa"
    t.boolean  "inscrito"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "automoviles", ["placa"], name: "index_automoviles_on_placa", unique: true

  create_table "informes", force: :cascade do |t|
    t.integer  "num_autos_parqueados"
    t.integer  "num_autos_inscritos"
    t.integer  "total_recaudo"
    t.datetime "fecha_informe"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "fecha"
  end

  create_table "parqueos", force: :cascade do |t|
    t.integer  "automovil_id"
    t.datetime "hora_entrada"
    t.datetime "hora_salida"
    t.decimal  "valor_servicio"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "parqueos", ["automovil_id"], name: "index_parqueos_on_automovil_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true

end
