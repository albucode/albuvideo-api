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

ActiveRecord::Schema.define(version: 2021_08_23_181630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"

  create_table "access_tokens", force: :cascade do |t|
    t.string "name", null: false
    t.string "access_token", limit: 32, null: false
    t.string "public_id", limit: 10, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token"], name: "index_access_tokens_on_access_token", unique: true
    t.index ["public_id"], name: "index_access_tokens_on_public_id", unique: true
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "country_permissions", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_country_permissions_on_country_id"
    t.index ["video_id"], name: "index_country_permissions_on_video_id"
  end

  create_table "geolocations", force: :cascade do |t|
    t.bigint "ip_from"
    t.bigint "ip_to"
    t.string "country_code"
    t.string "country"
    t.string "region"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_code"], name: "index_geolocations_on_country_code"
    t.index ["ip_from"], name: "index_geolocations_on_ip_from"
    t.index ["ip_to"], name: "index_geolocations_on_ip_to"
  end

  create_table "segments", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.integer "position", null: false
    t.float "duration", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["position", "variant_id"], name: "index_segments_on_position_and_variant_id", unique: true
    t.index ["variant_id"], name: "index_segments_on_variant_id"
  end

  create_table "signature_keys", force: :cascade do |t|
    t.string "name", null: false
    t.string "signature_key", limit: 64, null: false
    t.string "public_id", limit: 10, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_id"], name: "index_signature_keys_on_public_id", unique: true
    t.index ["signature_key"], name: "index_signature_keys_on_signature_key", unique: true
    t.index ["user_id"], name: "index_signature_keys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.string "public_id", null: false
    t.integer "height", null: false
    t.integer "width", null: false
    t.integer "bitrate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_id"], name: "index_variants_on_public_id", unique: true
    t.index ["video_id"], name: "index_variants_on_video_id"
  end

  create_table "video_stream_events", force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "user_id", null: false
    t.float "duration", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "session_id"
    t.index ["user_id"], name: "index_video_stream_events_on_user_id"
    t.index ["video_id"], name: "index_video_stream_events_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.boolean "published"
    t.integer "status"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "public_id", limit: 10, null: false
    t.bigint "user_id", null: false
    t.string "country_permission_type"
    t.index ["public_id"], name: "index_videos_on_public_id", unique: true
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  create_table "webhook_subscriptions", force: :cascade do |t|
    t.string "topic", null: false
    t.string "url", null: false
    t.bigint "user_id", null: false
    t.string "public_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_id"], name: "index_webhook_subscriptions_on_public_id", unique: true
    t.index ["user_id"], name: "index_webhook_subscriptions_on_user_id"
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "country_permissions", "countries"
  add_foreign_key "country_permissions", "videos"
  add_foreign_key "segments", "variants"
  add_foreign_key "signature_keys", "users"
  add_foreign_key "variants", "videos"
  add_foreign_key "video_stream_events", "users"
  add_foreign_key "video_stream_events", "videos"
  add_foreign_key "videos", "users"
  add_foreign_key "webhook_subscriptions", "users"
end
