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
video = Video.create!({ title: 'Video1', published: true, source: 'http://www.sourceseed.com', user_id: user.id,
                        country_permission_type: 'allowed' })
Service.create!({ name: 'Video streaming', category: :streaming, description: 'This is the description', price: 0.0001 })

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
