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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131121074229) do

  create_table "initial_costs", :force => true do |t|
    t.integer  "loan_id"
    t.string   "name"
    t.decimal  "amount",     :precision => 14, :scale => 7, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "loans", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "sale_price",            :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "initial_payment",       :precision => 14, :scale => 7, :default => 0.0
    t.date     "start_at"
    t.integer  "frequency"
    t.string   "grace_period_type"
    t.integer  "total_days"
    t.decimal  "annual_interest_rate",  :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "annual_inflation_rate", :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "discount_rate",         :precision => 14, :scale => 7, :default => 0.0
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.decimal  "amount_payable",        :precision => 14, :scale => 7, :default => 0.0
    t.integer  "total_time"
    t.integer  "total_time_type"
    t.integer  "days_per_year",                                        :default => 360
    t.decimal  "irr",                   :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "npv",                   :precision => 14, :scale => 7, :default => 0.0
  end

  create_table "payments", :force => true do |t|
    t.integer  "loan_id"
    t.integer  "payment_index"
    t.date     "start_at"
    t.decimal  "annual_interest_rate",    :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "periodic_interest_rate",  :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "annual_inflation_rate",   :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "periodic_inflation_rate", :precision => 14, :scale => 7, :default => 0.0
    t.string   "grace_period_type"
    t.decimal  "opening_balance",         :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "interest",                :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "amortization",            :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "quota",                   :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "final_balance",           :precision => 14, :scale => 7, :default => 0.0
    t.decimal  "cash_flow",               :precision => 14, :scale => 7, :default => 0.0
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.decimal  "prepayment",              :precision => 14, :scale => 7, :default => 0.0
  end

  create_table "recurrent_costs", :force => true do |t|
    t.integer  "loan_id"
    t.string   "name"
    t.decimal  "amount",     :precision => 14, :scale => 7, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
