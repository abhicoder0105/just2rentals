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

ActiveRecord::Schema[8.1].define(version: 2026_05_25_095409) do
  create_table "admin_actions", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.text "metadata"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["action"], name: "index_admin_actions_on_action"
    t.index ["resource_type", "resource_id"], name: "index_admin_actions_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_admin_actions_on_user_id"
  end

  create_table "admin_invitations", force: :cascade do |t|
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "expires_at"
    t.integer "invited_by_id", null: false
    t.string "role"
    t.string "token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_invitations_on_email"
    t.index ["invited_by_id"], name: "index_admin_invitations_on_invited_by_id"
    t.index ["role"], name: "index_admin_invitations_on_role"
    t.index ["token"], name: "index_admin_invitations_on_token", unique: true
  end

  create_table "content_blocks", force: :cascade do |t|
    t.boolean "active", default: true
    t.text "body"
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "key"
    t.string "placement"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_content_blocks_on_active"
    t.index ["key"], name: "index_content_blocks_on_key", unique: true
    t.index ["placement"], name: "index_content_blocks_on_placement"
  end

  create_table "coupons", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "code"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "discount_type"
    t.date "ends_on"
    t.date "starts_on"
    t.datetime "updated_at", null: false
    t.integer "usage_limit", default: 0
    t.integer "used_count", default: 0
    t.decimal "value", precision: 8, scale: 2
    t.index ["active"], name: "index_coupons_on_active"
    t.index ["code"], name: "index_coupons_on_code", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "vehicle_id", null: false
    t.index ["user_id", "vehicle_id"], name: "index_favorites_on_user_id_and_vehicle_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["vehicle_id"], name: "index_favorites_on_vehicle_id"
  end

  create_table "leads", force: :cascade do |t|
    t.decimal "budget", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.string "email"
    t.date "follow_up_on"
    t.string "name"
    t.text "notes"
    t.string "phone"
    t.string "preferred_vehicle"
    t.string "priority"
    t.string "source"
    t.string "status"
    t.string "trip_location"
    t.datetime "updated_at", null: false
    t.index ["follow_up_on"], name: "index_leads_on_follow_up_on"
    t.index ["priority"], name: "index_leads_on_priority"
    t.index ["status"], name: "index_leads_on_status"
  end

  create_table "maintenance_logs", force: :cascade do |t|
    t.date "completed_on"
    t.decimal "cost", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.text "notes"
    t.integer "odometer"
    t.date "scheduled_on"
    t.string "service_type"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "vehicle_id", null: false
    t.index ["scheduled_on"], name: "index_maintenance_logs_on_scheduled_on"
    t.index ["status"], name: "index_maintenance_logs_on_status"
    t.index ["vehicle_id"], name: "index_maintenance_logs_on_vehicle_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "kind"
    t.datetime "read_at"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["kind"], name: "index_notifications_on_kind"
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.text "metadata"
    t.datetime "paid_at"
    t.string "provider"
    t.integer "reservation_id", null: false
    t.string "status", default: "Pending"
    t.string "transaction_id"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["transaction_id"], name: "index_payments_on_transaction_id", unique: true
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "key"
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_permissions_on_category"
    t.index ["key"], name: "index_permissions_on_key", unique: true
  end

  create_table "rental_documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "document_type"
    t.string "file_name"
    t.text "notes"
    t.integer "reservation_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["document_type"], name: "index_rental_documents_on_document_type"
    t.index ["reservation_id"], name: "index_rental_documents_on_reservation_id"
    t.index ["status"], name: "index_rental_documents_on_status"
  end

  create_table "reservations", force: :cascade do |t|
    t.text "admin_notes"
    t.text "cancellation_reason"
    t.datetime "cancelled_at"
    t.string "confirmation_code"
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.decimal "deposit_amount", precision: 10, scale: 2
    t.string "deposit_status", default: "Pending"
    t.string "document_status", default: "Pending review"
    t.integer "driver_age"
    t.date "dropoff_date"
    t.string "dropoff_location"
    t.string "dropoff_time"
    t.string "email"
    t.text "extras"
    t.string "first_name"
    t.string "invoice_number"
    t.string "last_name"
    t.text "notes"
    t.string "phone"
    t.date "pickup_date"
    t.string "pickup_location"
    t.string "pickup_time"
    t.text "pricing_snapshot"
    t.string "protection_plan"
    t.datetime "reviewed_at"
    t.string "reviewed_by"
    t.string "status"
    t.decimal "total_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "vehicle_id", null: false
    t.index ["confirmation_code"], name: "index_reservations_on_confirmation_code", unique: true
    t.index ["coupon_id"], name: "index_reservations_on_coupon_id"
    t.index ["deposit_status"], name: "index_reservations_on_deposit_status"
    t.index ["document_status"], name: "index_reservations_on_document_status"
    t.index ["invoice_number"], name: "index_reservations_on_invoice_number", unique: true
    t.index ["status"], name: "index_reservations_on_status"
    t.index ["user_id"], name: "index_reservations_on_user_id"
    t.index ["vehicle_id"], name: "index_reservations_on_vehicle_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.boolean "approved", default: false
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "rating"
    t.integer "reservation_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "vehicle_id", null: false
    t.index ["approved"], name: "index_reviews_on_approved"
    t.index ["rating"], name: "index_reviews_on_rating"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["vehicle_id"], name: "index_reviews_on_vehicle_id"
  end

  create_table "support_tickets", force: :cascade do |t|
    t.string "assigned_to"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "message"
    t.string "priority", default: "Medium"
    t.integer "reservation_id"
    t.datetime "resolved_at"
    t.string "status", default: "Open"
    t.string "subject"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["priority"], name: "index_support_tickets_on_priority"
    t.index ["reservation_id"], name: "index_support_tickets_on_reservation_id"
    t.index ["status"], name: "index_support_tickets_on_status"
    t.index ["user_id"], name: "index_support_tickets_on_user_id"
  end

  create_table "user_permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "permission_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["permission_id"], name: "index_user_permissions_on_permission_id"
    t.index ["user_id", "permission_id"], name: "index_user_permissions_on_user_id_and_permission_id", unique: true
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "last_login_at"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.string "role", default: "customer", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "vehicles", force: :cascade do |t|
    t.boolean "available", default: true
    t.string "category"
    t.datetime "created_at", null: false
    t.decimal "daily_rate", precision: 8, scale: 2
    t.text "description"
    t.integer "doors"
    t.string "drivetrain"
    t.boolean "featured", default: false
    t.string "fuel"
    t.string "hero_color"
    t.string "image_url"
    t.string "location"
    t.integer "luggage"
    t.string "make"
    t.string "mileage"
    t.string "model"
    t.string "name"
    t.decimal "rating", precision: 3, scale: 1
    t.integer "seats"
    t.string "transmission"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["category"], name: "index_vehicles_on_category"
    t.index ["daily_rate"], name: "index_vehicles_on_daily_rate"
    t.index ["location"], name: "index_vehicles_on_location"
  end

  add_foreign_key "admin_actions", "users"
  add_foreign_key "admin_invitations", "users", column: "invited_by_id"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "vehicles"
  add_foreign_key "maintenance_logs", "vehicles"
  add_foreign_key "notifications", "users"
  add_foreign_key "payments", "reservations"
  add_foreign_key "payments", "users"
  add_foreign_key "rental_documents", "reservations"
  add_foreign_key "reservations", "coupons"
  add_foreign_key "reservations", "users"
  add_foreign_key "reservations", "vehicles"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "vehicles"
  add_foreign_key "support_tickets", "reservations"
  add_foreign_key "support_tickets", "users"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
end
