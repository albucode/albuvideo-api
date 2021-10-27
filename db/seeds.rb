# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'json'

user = User.create!({ email: 'a@a.com', password: 'asdasdasd', is_admin: true })
video = Video.create!({ title: 'Video1', published: true,
                        source: 'https://albuvideo.sfo3.digitaloceanspaces.com/dev/albukao_short.mp4',
                        user_id: user.id, country_permission_type: 'allowed' })
AttachSourceFileJob.perform_later(video.id)
Service.create!({ name: 'Video streaming', category: :streaming, description: 'This is the description',
                  price: 0.0001 })

3.times do
  VideoStreamEvent.create!({ duration: 2.5, video_id: video.id, user_id: user.id })
end

3.times do
  VideoStreamEvent.create!({ duration: 2.5, video_id: video.id, user_id: user.id, created_at: 10.minutes.ago })
end

csv_text = File.read(Rails.root.join('db/geolocation.csv'))
csv = CSV.parse(csv_text, headers: true)
locations = []
csv.each do |row|
  locations << Geolocation.new(row.to_hash)
end
Geolocation.import! locations

countries_text = File.read(Rails.root.join('db/countries.json'))
json = JSON.parse(countries_text)
countries = []
json.each do |key, value|
  countries << Country.new(code: key, name: value)
end
Country.import! countries

service = Service.find_by(category: 'streaming')
beginning_of_last_month = Time.zone.now.last_month.beginning_of_month
end_of_last_month = Time.zone.now.last_month.end_of_month

invoice = Invoice.create!(start_date: beginning_of_last_month, end_date: end_of_last_month, user_id: user.id,
                          status: :pending)
InvoiceItem.create!(service_id: service.id,
                    quantity: 10,
                    invoice_id: invoice.id, user_id: user.id,
                    price: service.price)
