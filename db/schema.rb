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

ActiveRecord::Schema.define(version: 20140407154205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acessos", force: true do |t|
    t.string   "ip"
    t.integer  "linha_ponto_linha_ponto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acessos", ["linha_ponto_linha_ponto_id"], name: "index_acessos_on_linha_ponto_linha_ponto_id", using: :btree

  create_table "dias", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "horarios", force: true do |t|
    t.time     "partida"
    t.time     "chegada"
    t.integer  "linha_ponto_linha_ponto_id"
    t.string   "via"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horarios", ["linha_ponto_linha_ponto_id"], name: "index_horarios_on_linha_ponto_linha_ponto_id", using: :btree

  create_table "linhas", force: true do |t|
    t.string   "codigo"
    t.string   "nome"
    t.integer  "tipo_linha_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "linhas", ["tipo_linha_id"], name: "index_linhas_on_tipo_linha_id", using: :btree

  create_table "linhas_pontos", force: true do |t|
    t.integer  "linha_id"
    t.integer  "ponto_id"
    t.integer  "dia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "linhas_pontos", ["dia_id"], name: "index_linhas_pontos_on_dia_id", using: :btree
  add_index "linhas_pontos", ["linha_id"], name: "index_linhas_pontos_on_linha_id", using: :btree
  add_index "linhas_pontos", ["ponto_id"], name: "index_linhas_pontos_on_ponto_id", using: :btree

  create_table "linhas_pontos_linhas_pontos", force: true do |t|
    t.integer  "origem_id"
    t.integer  "destino_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "linhas_pontos_linhas_pontos", ["destino_id"], name: "index_linhas_pontos_linhas_pontos_on_destino_id", using: :btree
  add_index "linhas_pontos_linhas_pontos", ["origem_id"], name: "index_linhas_pontos_linhas_pontos_on_origem_id", using: :btree

  create_table "pontos", force: true do |t|
    t.string   "codigo"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posicoes", force: true do |t|
    t.string   "de"
    t.string   "para"
    t.decimal  "lat"
    t.decimal  "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos_linhas", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
