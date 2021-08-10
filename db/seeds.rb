# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

user = User.create!({ email: 'a@a.com', password: 'asdasdasd' })
video = Video.create!({ title: 'Video1', published: true, source: 'http://www.sourceseed.com', user_id: user.id })

3.times do
  VideoStreamEvent.create!({ duration: 2.5, video_id: video.id, user_id: user.id })
end

3.times do
  VideoStreamEvent.create!({ duration: 2.5, video_id: video.id, user_id: user.id, created_at: 10.minutes.ago })
end

csv_text = File.read(Rails.root.join('db', 'geolocation.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Geolocation.create!(row.to_hash)
end
